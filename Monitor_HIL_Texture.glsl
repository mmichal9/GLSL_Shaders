// Uncomment if running in VS Code:
//#iChannel0 "file://./texture/texture_road.jpg"
//#iChannel0::WrapMode "Repeat"


const int DIRECTION  = 1; // 1, 2, 3, 4;


void mainImage( out vec4 fragColor, in vec2 fragCoord ) {

    float zoom = 1.5;	// 1.5x zoom on the texture in respect to x
    float speed = 10.0; // 10 s to pass screen x resolution

    zoom = 1./zoom;
    vec2 uv = fragCoord/iResolution.x;
    uv *= zoom;

    fragColor = texture(iChannel0, vec2(uv.y+((iTime/speed)*zoom), uv.x));


    if(DIRECTION == 1){
        fragColor = texture(iChannel0, vec2(uv.x+((iTime/speed)*zoom), uv.y));
    } else if(DIRECTION == 2){
    	fragColor = texture(iChannel0, vec2(uv.x-((iTime/speed)*zoom), uv.y));
    } else if(DIRECTION == 3){
    	fragColor = texture(iChannel0, vec2(uv.y-((iTime/speed)*zoom), uv.x));
    } else if(DIRECTION == 4){
    	fragColor = texture(iChannel0, vec2(uv.y+((iTime/speed)*zoom), uv.x));
    }else{
    	fragColor = vec4(1., 0., 0., 1.);
    }


}