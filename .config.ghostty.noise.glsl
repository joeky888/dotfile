// https://dev.to/0xkoji/ghostty-use-fragment-shader-as-terminal-background-11g3

float random(in vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

vec2 random_gradient(in vec2 i) {
    float r = 2.0 * 3.1415926535 * random(i);
    return vec2(cos(r), sin(r));
}

float perlin_noise(in vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);

    vec2 g00 = random_gradient(i + vec2(0.0, 0.0));
    vec2 g10 = random_gradient(i + vec2(1.0, 0.0));
    vec2 g01 = random_gradient(i + vec2(0.0, 1.0));
    vec2 g11 = random_gradient(i + vec2(1.0, 1.0));

    vec2 p00 = f - vec2(0.0, 0.0);
    vec2 p10 = f - vec2(1.0, 0.0);
    vec2 p01 = f - vec2(0.0, 1.0);
    vec2 p11 = f - vec2(1.0, 1.0);

    float n00 = dot(g00, p00);
    float n10 = dot(g10, p10);
    float n01 = dot(g01, p01);
    float n11 = dot(g11, p11);

    vec2 u = f * f * (3.0 - 2.0 * f);

    float nx0 = mix(n00, n10, u.x);
    float nx1 = mix(n01, n11, u.x);
    float nxy = mix(nx0, nx1, u.y);

    return (nxy + 1.0) / 2.0;
}


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord / iResolution.xy;
    vec2 noiseUV = uv * 4.0;
    noiseUV += iTime * 0.5;

    vec3 col = 0.5 + 0.5 * cos(iTime + noiseUV.xyx + vec3(0.0, 2.0, 4.0));
    float noise_val = perlin_noise(noiseUV);
    col *= noise_val;

    vec4 terminalColor = texture(iChannel0, uv);
    vec3 blendedColor = terminalColor.rgb + col.rgb * 0.7;

    fragColor = vec4(blendedColor,1.0);
}
