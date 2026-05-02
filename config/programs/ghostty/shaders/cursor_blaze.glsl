// Based on https://gist.github.com/chardskarth/95874c54e29da6b5a36ab7b50ae2d088
float ease(float x) {
    return pow(1.0 - x, 10.0);
}

float getSdfRectangle(in vec2 p, in vec2 xy, in vec2 b)
{
    vec2 d = abs(p - xy) - b;
    return length(max(d, 0.0)) + min(max(d.x, d.y), 0.0);
}

float seg(in vec2 p, in vec2 a, in vec2 b, inout float s, float d) {
    vec2 e = b - a;
    vec2 w = p - a;
    vec2 proj = a + e * clamp(dot(w, e) / dot(e, e), 0.0, 1.0);
    float segd = dot(p - proj, p - proj);
    d = min(d, segd);

    float c0 = step(0.0, p.y - a.y);
    float c1 = 1.0 - step(0.0, p.y - b.y);
    float c2 = 1.0 - step(0.0, e.x * w.y - e.y * w.x);
    float allCond = c0 * c1 * c2;
    float noneCond = (1.0 - c0) * (1.0 - c1) * (1.0 - c2);
    float flip = mix(1.0, -1.0, step(0.5, allCond + noneCond));
    s *= flip;
    return d;
}

float getSdfParallelogram(in vec2 p, in vec2 v0, in vec2 v1, in vec2 v2, in vec2 v3) {
    float s = 1.0;
    float d = dot(p - v0, p - v0);

    d = seg(p, v0, v3, s, d);
    d = seg(p, v1, v0, s, d);
    d = seg(p, v2, v1, s, d);
    d = seg(p, v3, v2, s, d);

    return s * sqrt(d);
}

vec2 normalizeCoord(vec2 value, float isPosition) {
    return (value * 2.0 - (iResolution.xy * isPosition)) / iResolution.y;
}

float blend(float t)
{
    float sqr = t * t;
    return sqr / (2.0 * (sqr - t) + 1.0);
}

float antialising(float distance) {
    return 1. - smoothstep(0., normalizeCoord(vec2(2., 2.), 0.).x, distance);
}

float determineStartVertexFactor(vec2 a, vec2 b) {
    float condition1 = step(b.x, a.x) * step(a.y, b.y);
    float condition2 = step(a.x, b.x) * step(b.y, a.y);
    return 1.0 - max(condition1, condition2);
}

vec2 getRectangleCenter(vec4 rectangle) {
    return vec2(rectangle.x + (rectangle.z / 2.), rectangle.y - (rectangle.w / 2.));
}

float random(vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898,78.233))) * 43758.5453123);
}

float getCircleMask(vec2 uv, float alphaMod) {
    vec2 grid = uv * 40.0; 
    vec2 id = floor(grid);
    vec2 f = fract(grid) - 0.5;

    float randVal = random(id);

    float maxRadius = smoothstep(0.2, 1.0, alphaMod) * randVal * 0.8;
    float dist = length(f);
    
    return smoothstep(maxRadius, maxRadius + 0.05, dist);
}

const float DURATION = .5;
const float DRAW_THRESHOLD = 1.5;
const bool HIDE_TRAILS_ON_THE_SAME_LINE = false;

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    vec4 TRAIL_COLOR_START = vec4(iPalette[4], 1.0);
    vec4 TRAIL_COLOR_END = vec4(iPalette[2], 1.0);
    vec4 TRAIL_COLOR_ACCENT = vec4(mix(iPalette[2], iPalette[4], 0.5), 1.0);

    #if !defined(WEB)
    fragColor = texture(iChannel0, fragCoord.xy / iResolution.xy);
    #endif

    vec2 vu = normalizeCoord(fragCoord, 1.);
    vec2 offsetFactor = vec2(-.5, 0.5);

    vec4 currentCursor = vec4(normalizeCoord(iCurrentCursor.xy, 1.), normalizeCoord(iCurrentCursor.zw, 0.));
    vec4 previousCursor = vec4(normalizeCoord(iPreviousCursor.xy, 1.), normalizeCoord(iPreviousCursor.zw, 0.));

    float vertexFactor = determineStartVertexFactor(currentCursor.xy, previousCursor.xy);
    float invertedVertexFactor = 1.0 - vertexFactor;

    vec2 v0 = vec2(currentCursor.x + currentCursor.z * vertexFactor, currentCursor.y - currentCursor.w);
    vec2 v1 = vec2(currentCursor.x + currentCursor.z * invertedVertexFactor, currentCursor.y);
    vec2 v2 = vec2(previousCursor.x + currentCursor.z * invertedVertexFactor, previousCursor.y);
    vec2 v3 = vec2(previousCursor.x + currentCursor.z * vertexFactor, previousCursor.y - previousCursor.w);

    vec4 newColor = vec4(fragColor);

    float progress = blend(clamp((iTime - iTimeCursorChange) / DURATION, 0.0, 1));
    float easedProgress = ease(progress);

    vec2 centerCC = getRectangleCenter(currentCursor);
    vec2 centerCP = getRectangleCenter(previousCursor);
    float cursorSize = max(currentCursor.z, currentCursor.w);
    float trailThreshold = DRAW_THRESHOLD * cursorSize;
    float lineLength = distance(centerCC, centerCP);

    bool isFarEnough = lineLength > trailThreshold;
    bool isOnSeparateLine = HIDE_TRAILS_ON_THE_SAME_LINE ? currentCursor.y != previousCursor.y : true;
    if (isFarEnough && isOnSeparateLine) {
        float distanceToEnd = distance(vu.xy, centerCC);
        float alphaModifier = distanceToEnd / (lineLength * (easedProgress));

        if (alphaModifier > 1.0) {
            alphaModifier = 1.0;
        }

        vec4 trailGradient = mix(TRAIL_COLOR_START, TRAIL_COLOR_END, alphaModifier);

        float sdfCursor = getSdfRectangle(vu, currentCursor.xy - (currentCursor.zw * offsetFactor), currentCursor.zw * 0.5);
        float sdfTrail = getSdfParallelogram(vu, v0, v1, v2, v3);

        // 1. Puxamos a máscara original
        float mask = getCircleMask(vu, alphaModifier);
        
        // 2. Criamos uma proteção para a borda
        // O valor do sdfTrail é negativo dentro do rastro e vai até 0 na borda.
        // Se o pixel estiver muito perto da borda (entre -0.03 e -0.005), isEdge sobe para 1.0.
        float isEdge = smoothstep(-0.03, -0.005, sdfTrail);
        
        // 3. Mesclamos a máscara com a proteção:
        // Onde for borda (isEdge = 1.0), a máscara se torna 1.0, impedindo o buraco de existir ali.
        mask = max(mask, isEdge);

        newColor = mix(newColor, TRAIL_COLOR_ACCENT, 1.0 - smoothstep(sdfTrail, -0.01, 0.001));
        newColor = mix(newColor, trailGradient, antialising(sdfTrail));
        
        // A máscara agora só perfura o núcleo do rastro, deixando o glow ao redor sólido!
        newColor = mix(fragColor, newColor, (1.0 - alphaModifier) * mask);
        
        fragColor = mix(newColor, fragColor, step(sdfCursor, 0.0));
    }
}
