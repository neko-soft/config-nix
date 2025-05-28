{ config, pkgs, lib, ... }:

{

home.file = {

  ".config/glava/wave.glsl".text = ''
@module wave
#include wave/1.frag
#include wave/2.frag
/* min (vertical) line thickness */
#define MIN_THICKNESS 1

/* max (vertical) line thickness */
#define MAX_THICKNESS 6

/* base color to use, distance from center will multiply the RGB components */
#define BASE_COLOR vec4(0.36, 0.737, 0.839, 1)

/* amplitude */
#define AMPLIFY 500

/* outline color */
#define OUTLINE vec4(0.15, 0.15, 0.15, 1)


  '';

  ".config/glava/wave/1.frag".text = ''
layout(pixel_center_integer) in vec4 gl_FragCoord;

#request uniform "screen" screen
uniform ivec2     screen; /* screen dimensions */

#request uniform "audio_l" audio_l
#request transform audio_l "window"
#request transform audio_l "wrange"
uniform sampler1D audio_l;

out vec4 fragment;

#include "@wave.glsl"
#include ":wave.glsl"

#define index(offset) ((texture(audio_l, (gl_FragCoord.x + offset) / screen.x).r - 0.5) * AMPLIFY) + 0.5F

void main() {
    float
        os   = index(0),
        adj0 = index(-1),
        adj1 = index(1);
    float
        s0 = adj0 - os,
        s1 = adj1 - os;
    float
        dmax = max(s0, s1),
        dmin = min(s0, s1);
    
    float s = (os + (screen.y * 0.5F) - 0.5F); /* center to screen coords */
    float diff = gl_FragCoord.y - s;
    if (abs(diff) < clamp(abs(s - (screen.y * 0.5)) * 6, MIN_THICKNESS, MAX_THICKNESS)
        || (diff <= dmax && diff >= dmin)) {
        fragment = BASE_COLOR + (abs((screen.y * 0.5F) - s) * 0.02);
    } else {
        fragment = vec4(0.105, 0.121, 0.196, 0.9);
    }
}
  '';

  ".config/glava/wave/2.frag".text = ''
layout(pixel_center_integer) in vec4 gl_FragCoord;

#request uniform "prev" tex
uniform sampler2D tex;    /* screen texture    */
#request uniform "screen" screen
uniform ivec2     screen; /* screen dimensions */

out vec4 fragment; /* output */

#include "@wave.glsl"
#include ":wave.glsl"

void main() {
    fragment = texelFetch(tex, ivec2(gl_FragCoord.x, gl_FragCoord.y), 0);
    
    vec4
        a0 = texelFetch(tex, ivec2((gl_FragCoord.x + 1), (gl_FragCoord.y + 0)), 0),
        a1 = texelFetch(tex, ivec2((gl_FragCoord.x + 1), (gl_FragCoord.y + 1)), 0),
        a2 = texelFetch(tex, ivec2((gl_FragCoord.x + 0), (gl_FragCoord.y + 1)), 0),
        a3 = texelFetch(tex, ivec2((gl_FragCoord.x + 1), (gl_FragCoord.y + 0)), 0),
    
        a4 = texelFetch(tex, ivec2((gl_FragCoord.x - 1), (gl_FragCoord.y - 0)), 0),
        a5 = texelFetch(tex, ivec2((gl_FragCoord.x - 1), (gl_FragCoord.y - 1)), 0),
        a6 = texelFetch(tex, ivec2((gl_FragCoord.x - 0), (gl_FragCoord.y - 1)), 0),
        a7 = texelFetch(tex, ivec2((gl_FragCoord.x - 1), (gl_FragCoord.y - 0)), 0);

    vec4 avg = (a0 + a1 + a2 + a3 + a4 + a5 + a6 + a7) / 8.0;
    if (avg.a > 0){
        if (fragment.a <= 0 || gl_FragCoord.x == 0 || gl_FragCoord.x == screen.x - 1)
            fragment = OUTLINE;
    }
}
  '';

};

}
