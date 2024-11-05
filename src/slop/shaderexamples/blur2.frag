#version 120

uniform sampler2D texture;
uniform vec2 screenSize;

varying vec2 uvCoord;

// Stolen from https://github.com/Jam3/glsl-fast-gaussian-blur kinda
void main()
{
    float radius = 1;
    vec4 color = vec4(0.0);
    vec2 off1 = vec2(1.411764705882353) * vec2( 0, radius );
    vec2 off2 = vec2(3.2941176470588234) * vec2( 0, radius );
    vec2 off3 = vec2(5.176470588235294) * vec2( 0, radius );
    color += texture2D(texture, uvCoord) * 0.1964825501511404;
    color += texture2D(texture, uvCoord + (off1 / screenSize)) * 0.2969069646728344;
    color += texture2D(texture, uvCoord - (off1 / screenSize)) * 0.2969069646728344;
    color += texture2D(texture, uvCoord + (off2 / screenSize)) * 0.09447039785044732;
    color += texture2D(texture, uvCoord - (off2 / screenSize)) * 0.09447039785044732;
    color += texture2D(texture, uvCoord + (off3 / screenSize)) * 0.010381362401148057;
    color += texture2D(texture, uvCoord - (off3 / screenSize)) * 0.010381362401148057;
    gl_FragColor = color;
}
