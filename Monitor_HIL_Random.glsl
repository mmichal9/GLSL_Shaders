const int DIRECTION = 1; // 1, 2, 3, 4;
const bool COLOR = true;



// Sudo Random Generators:
float nrand( vec2 n ){
	return fract(sin(dot(n.xy, vec2(12.9898, 78.233)))* 43758.5453);
}

float N21_1( vec2 n ){
	float t = fract( n.y*n.x*0.322001 );
	float nrnd0 = nrand( n + 0.07*t );
	return nrnd0;
}

float N21_2( vec2 n ){
	float t = fract( n.y*0.24023 );
	float nrnd0 = nrand( n + 0.07*t );
	float nrnd1 = nrand( n + 0.11*t );
	return (nrnd0+nrnd1) / 2.0;
}

float N21_3( vec2 n ){
	float t = fract( tan(n.x*.0321) );
	float nrnd0 = nrand( n + 0.07*t );
	float nrnd1 = nrand( n + 0.11*t );
	float nrnd2 = nrand( n + 0.13*t );
	return (nrnd0+nrnd1+nrnd2) / 3.0;
}

float N21_4(vec2 p){
	return fract(sin(dot(p, vec2(12.9898, 78.233))) * 43758.5453);
}




void mainImage( out vec4 fragColor, in vec2 fragCoord ) {

    float scale = 200.0;   // 10 "pix" blocks in x axis in respect to screen resolution
    float speed = 10.0;   // 10 s to pass screen x resolution

    speed = 1.0/speed;
    vec2 uv = (fragCoord -0.5*iResolution.xy)/iResolution.x; // iResolution.y makes uv*scale fit y coord
    vec3 col = vec3(1.0, 0.0, 0.0);


    uv *= scale; //repeat uv
    float move = iTime*(speed*scale);

    // Direction:
    if(DIRECTION == 1){ uv.x += move;}
    else if(DIRECTION == 2){ uv.x -= move; }
    else if(DIRECTION == 3){ uv.y += move; }
    else if(DIRECTION == 4){ uv.y -= move; }
    else{ fragColor = vec4(col, 1.);}

    // Grid and id:
    vec2 gv = fract(uv) - 0.5; // grid uv - center in the middle
    vec2 id = floor(uv); // identifier for each cell

    // Color:
    if(COLOR){
        float n_r = N21_1(id*0.17); // return "random" number for each cell (0-1)
        float n_g = N21_4(id*.042);
        float n_b = N21_2(id*.0342);
    	col = vec3(n_r, n_g, n_b);
    } else {
        float n_r = N21_1(id);
        col = vec3(n_r, n_r, n_r);
    }

    // if (gv.x >.40 || gv.y >.40) {col = vec3(1.0, 0, 0);} // draw the outline of the box
    fragColor = vec4(col, 1.0);

}