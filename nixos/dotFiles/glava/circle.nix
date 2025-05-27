{ config, pkgs, lib, ... }:

{

home.file = {

   ".config/glava/circle.glsl".text = ''
/* center radius (pixels) */
#define C_RADIUS 128
/* center line thickness (pixels) */
#define C_LINE 1.5
/* outline color */
#define OUTLINE #333333
/* Amplify magnitude of the results each bar displays */
#define AMPLIFY 150
/* Angle (in radians) for how much to rotate the visualizer */
#define ROTATE (PI / 2)
/* Whether to switch left/right audio buffers */
#define INVERT 0
/* Whether to fill in the space between the line and inner circle */
#define C_FILL 0
/* Whether to apply a post-processing image smoothing effect
   1 to enable, 0 to disable. Only works with `xroot` transparency,
   and improves performance if disabled. */
#define C_SMOOTH 1

/* Gravity step, overrude frin `smooth_parameters.glsl` */
#request setgravitystep 6.0

/* Smoothing factor, override from `smooth_parameters.glsl` */
#request setsmoothfactor 0.01
   '';

   ".config/glava/circle/1.frag".text = ''
layout(pixel_center_integer) in vec4 gl_FragCoord;

#request uniform "screen" screen
uniform ivec2 screen;

#request uniform "audio_sz" audio_sz
uniform int audio_sz;

#include ":util/smooth.glsl"
#include "@circle.glsl"
#include ":circle.glsl"

#request uniform "audio_l" audio_l
#request transform audio_l "window"
#request transform audio_l "fft"
#request transform audio_l "gravity"
#request transform audio_l "avg"
uniform sampler1D audio_l;

#request uniform "audio_r" audio_r
#request transform audio_r "window"
#request transform audio_r "fft"
#request transform audio_r "gravity"
#request transform audio_r "avg"
uniform sampler1D audio_r;

out vec4 fragment;

#define TWOPI 6.28318530718
#define PI 3.14159265359

/* This shader is based on radial.glsl, refer to it for more commentary */

float apply_smooth(float theta) {
    float idx = theta + ROTATE;
    float dir = mod(abs(idx), TWOPI);
    if (dir > PI)
        idx = -sign(idx) * (TWOPI - dir);
    if (INVERT > 0)
        idx = -idx;
    
    float pos = abs(idx) / (PI + 0.001F);
    #define smooth_f(tex) smooth_audio(tex, audio_sz, pos)
    float v;
    if (idx > 0) v = smooth_f(audio_l);
    else         v = smooth_f(audio_r);
    v *= AMPLIFY;      
    #undef smooth_f
    return v;
}

void main() {
    fragment = vec4(0, 0, 0, 0);
    float
        dx = gl_FragCoord.x - (screen.x / 2),
        dy = gl_FragCoord.y - (screen.y / 2);
    float theta = atan(dy, dx);
    float d = sqrt((dx * dx) + (dy * dy));
    float adv = (1.0F / d) * (C_LINE * 0.5);
    float
        adj0 = theta + adv,
        adj1 = theta - adv;
    d -= C_RADIUS;
    if (d >= -(float(C_LINE) / 2.0F)) {
        float v = apply_smooth(theta);
        
        adj0 = apply_smooth(adj0) - v;
        adj1 = apply_smooth(adj1) - v;
        
        float
            dmax = max(adj0, adj1),
            dmin = min(adj0, adj1);
        
        d -= v;
        #if C_FILL > 0
        #define BOUNDS (d < (float(C_LINE) / 2.0F))
        #else
        #define BOUNDS (d > -(float(C_LINE) / 2.0F) && d < (float(C_LINE) / 2.0F)) || (d <= dmax && d >= dmin)
        #endif
        if (BOUNDS)  {
            fragment = OUTLINE;
        }
    }
}


   '';

    ".config/glava/circle/2.frag".text = ''

in vec4 gl_FragCoord;

#request uniform "prev" tex
uniform sampler2D tex;    /* screen texture    */

out vec4 fragment; /* output */

#include "@circle.glsl"
#include ":circle.glsl"

void main() {
    fragment = texelFetch(tex, ivec2(gl_FragCoord.x, gl_FragCoord.y), 0);
    #if C_SMOOTH > 0
    #if USE_ALPHA
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
    if (fragment.a == 0) {
        fragment = avg;
    }
    #endif
    #endif
}


   '';

    ".config/glava/circle/3.frag".text = ''
#include ":util/premultiply.frag"


   '';




};
}