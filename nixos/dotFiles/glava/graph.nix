{ config, pkgs, lib, ... }:

{

home.file = {


".config/glava/graph.glsl".text = ''

/* Vertical scale, larger values will amplify output */
#define VSCALE 300
/* Rendering direction, either -1 (outwards) or 1 (inwards). */
#define DIRECTION 1

/* Color gradient scale, (optionally) used in `COLOR` macro */
#define GRADIENT_SCALE 75
/* Color definition. By default this is a gradient formed by mixing two colors.
   `pos` represents the pixel position relative to the visualizer baseline. */
#define COLOR mix(#802A2A, #4F4F92, clamp(pos / GRADIENT_SCALE, 0, 1))
/* 1 to draw outline, 0 to disable */
#define DRAW_OUTLINE 0
/* 1 to draw edge highlight, 0 to disable */
#define DRAW_HIGHLIGHT 1
/* Whether to anti-alias the border of the graph, creating a smoother curve.
   This may have a small impact on performance.
   Note: requires `xroot` or `none` opacity to be set */
#define ANTI_ALIAS 0
/* outline color */
#define OUTLINE #262626
/* 1 to join the two channels together in the middle, 0 to clamp both down to zero */
#define JOIN_CHANNELS 0
/* 1 to invert (vertically), 0 otherwise */
#define INVERT 0

/* Gravity step, overrude from `smooth_parameters.glsl` */
#request setgravitystep 2.4

/* Smoothing factor, override from `smooth_parameters.glsl` */
#request setsmoothfactor 0.015

'';


  ".config/glava/graph/1.frag".text = ''

layout(pixel_center_integer) in vec4 gl_FragCoord;

#request uniform "screen" screen
uniform ivec2 screen; /* screen dimensions */

#request uniform "audio_sz" audio_sz
uniform int audio_sz;

/* When we transform our audio, we need to go through the following steps: 
   
   transform -> "window"
       First, apply a window function to taper off the ends of the spectrum, helping
       avoid artifacts in the FFT output.
   
   transform -> "fft"
       Apply the Fast Fourier Transform algorithm to separate raw audio data (waves)
       into their respective spectrums.
   
   transform -> "fft"
       As part of the FFT process, we return spectrum magnitude on a log(n) scale,
       as this is how the (decibel) dB scale functions.
       
   transform -> "gravity"
       To help make our data more pleasing to look at, we apply our data received over
       time to a buffer, taking the max of either the existing value in the buffer or
       the data from the input. We then reduce the data by the 'gravity step', and
       return the storage buffer.
       
       This makes frequent and abrupt changes in frequency less distracting, and keeps
       short frequency responses on the screen longer.
       
   transform -> "avg"
       As a final step, we take the average of several data frames (specified by
       'setavgframes') and return the result to further help smooth the resulting
       animation. In order to mitigate abrupt changes to the average, the values
       at each end of the average buffer can be weighted less with a window function
       (the same window function used at the start of this step!). It can be disabled
       with 'setavgwindow'.
*/

#include ":util/smooth.glsl"
#include "@graph.glsl"
#include ":graph.glsl"

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

/* distance from center */
#define CDIST (abs((screen.x / 2) - gl_FragCoord.x) / screen.x)
/* distance from sides (far) */
#define FDIST (min(gl_FragCoord.x, screen.x - gl_FragCoord.x) / screen.x)

#if DIRECTION < 0
#define LEFT_IDX (gl_FragCoord.x)
#define RIGHT_IDX (-gl_FragCoord.x + screen.x)
/* distance from base frequencies */
#define BDIST FDIST
/* distance from high frequencies */
#define HDIST CDIST
#else
#define LEFT_IDX (half_w - gl_FragCoord.x)
#define RIGHT_IDX (gl_FragCoord.x - half_w)
#define BDIST CDIST
#define HDIST FDIST
#endif

#define TWOPI 6.28318530718

float half_w;
float middle;
highp float pixel = 1.0F / float(screen.x);

float get_line_height(in sampler1D tex, float idx) {
    float s = smooth_audio_adj(tex, audio_sz, idx / half_w, pixel);
    /* scale the data upwards so we can see it */
    s *= VSCALE;
    /* clamp far ends of the screen down to make the ends of the graph smoother */

    float fact = clamp((abs((screen.x / 2) - gl_FragCoord.x) / screen.x) * 48, 0.0F, 1.0F);
    #if JOIN_CHANNELS > 0
    fact = -2 * pow(fact, 3) + 3 * pow(fact, 2);    /* To avoid spikes */
    s = fact * s + (1 - fact) * middle;
    #else
    s *= fact;
    #endif

    s *= clamp((min(gl_FragCoord.x, screen.x - gl_FragCoord.x) / screen.x) * 48, 0.0F, 1.0F);

    return s;
}

void render_side(in sampler1D tex, float idx) {
    float s = get_line_height(tex, idx);

    /* and finally set fragment color if we are in range */
    #if INVERT > 0
    float pos = float(screen.y) - gl_FragCoord.y;
    #else
    float pos = gl_FragCoord.y;
    #endif
    if (pos + 1.5 <= s) {
        fragment = COLOR;
    } else {
        fragment = vec4(0, 0, 0, 0);
    }
}

void main() {
    half_w = (screen.x / 2);

    middle = VSCALE * (smooth_audio_adj(audio_l, audio_sz, 1, pixel) + smooth_audio_adj(audio_r, audio_sz, 0, pixel)) / 2;

    if (gl_FragCoord.x < half_w) {
        render_side(audio_l, LEFT_IDX);
    } else {
        render_side(audio_r, RIGHT_IDX);
    }
}


  '';

    ".config/glava/graph/2.frag".text = ''

in vec4 gl_FragCoord;

#request uniform "prev" tex
uniform sampler2D tex;    /* screen texture    */

out vec4 fragment; /* output */

#include "@graph.glsl"
#include ":graph.glsl"

#if DRAW_OUTLINE == 0 && DRAW_HIGHLIGHT == 0
#error __disablestage
#endif

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
        if (fragment.a <= 0) {
            /* outline */
            #if DRAW_OUTLINE > 0
            fragment = OUTLINE;
            #endif
        } else if (avg.a < 1) {
            /* creates a highlight along the edge of the spectrum */
            #if DRAW_HIGHLIGHT > 0
            fragment.rgb *= avg.a * 2;
            #endif
        }
    }
}


  '';


  ".config/glava/graph/3.frag".text = ''

in vec4 gl_FragCoord;

#request uniform "screen" screen
uniform ivec2 screen; /* screen dimensions */

#request uniform "prev" tex
uniform sampler2D tex;    /* screen texture    */

out vec4 fragment; /* output */

#include "@graph.glsl"
#include ":graph.glsl"

#if ANTI_ALIAS == 0
#error __disablestage
#endif

/* Moves toward the border of the graph, gives the
   y coordinate of the last colored pixel */
float get_col_height_up(float x, float oy) {
    float y = oy;
    #if INVERT > 0
    while (y >= 0) {
    #else
    while (y < screen.y) {
    #endif
        vec4 f = texelFetch(tex, ivec2(x, y), 0);
        if (f.a <= 0) {
            #if INVERT > 0
            y += 1;
            #else
            y -= 1;
            #endif
            break;
        }
        #if INVERT > 0
        y -= 1;
        #else
        y += 1;
        #endif
    }

    return y;
}

/* Moves toward the base of the graph, gives the
   y coordinate of the first colored pixel */
float get_col_height_down(float x, float oy) {
    float y = oy;
    #if INVERT > 0
    while (y < screen.y) {
    #else
    while (y >= 0) {
    #endif
        vec4 f = texelFetch(tex, ivec2(x, y), 0);
        if (f.a > 0) {
            break;
        }
        #if INVERT > 0
        y += 1;
        #else
        y -= 1;
        #endif
    }

    return y;
}

void main() {
    fragment = texelFetch(tex, ivec2(gl_FragCoord.x, gl_FragCoord.y), 0);

    #if ANTI_ALIAS > 0

    if (fragment.a <= 0) {
        bool left_done = false;
        float h2;
        float a_fact = 0;

        if (texelFetch(tex, ivec2(gl_FragCoord.x - 1, gl_FragCoord.y), 0).a > 0) {
            float h1 = get_col_height_up(gl_FragCoord.x - 1, gl_FragCoord.y);
            h2 = get_col_height_down(gl_FragCoord.x, gl_FragCoord.y);
            fragment = texelFetch(tex, ivec2(gl_FragCoord.x, h2), 0);

            a_fact = clamp(abs((h1 - gl_FragCoord.y) / (h2 - h1)), 0.0, 1.0);

            left_done = true;
        }
        if (texelFetch(tex, ivec2(gl_FragCoord.x + 1, gl_FragCoord.y), 0).a > 0) {
            if (!left_done) {
                h2 = get_col_height_down(gl_FragCoord.x, gl_FragCoord.y);
                fragment = texelFetch(tex, ivec2(gl_FragCoord.x, h2), 0);
            }
            float h3 = get_col_height_up(gl_FragCoord.x + 1, gl_FragCoord.y);

            a_fact = max(a_fact, clamp(abs((h3 - gl_FragCoord.y) / (h2 - h3)), 0.0, 1.0));
        }
        
        fragment.a *= a_fact;

    }

    #endif
}


  '';



};
}