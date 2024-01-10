RSRC                    VisualShader            ��������                                            l      resource_local_to_scene    resource_name    output_port_for_preview    default_input_values    expanded_output_ports    billboard_type    keep_scale    script    parameter_name 
   qualifier    texture_type    color_default    texture_filter    texture_repeat    texture_source    source    texture    op_type    input_name 	   operator    hint    min    max    step    default_value_enabled    default_value 	   function    code    graph_offset    mode    modes/blend    modes/depth_draw    modes/cull    modes/diffuse    modes/specular    flags/depth_prepass_alpha    flags/depth_test_disabled    flags/sss_mode_skin    flags/unshaded    flags/wireframe    flags/skip_vertex_transform    flags/world_vertex_coords    flags/ensure_correct_normals    flags/shadows_disabled    flags/ambient_light_disabled    flags/shadow_to_opacity    flags/vertex_lighting    flags/particle_trails    flags/alpha_to_coverage     flags/alpha_to_coverage_and_one    flags/debug_shadow_splits    flags/fog_disabled    nodes/vertex/0/position    nodes/vertex/2/node    nodes/vertex/2/position    nodes/vertex/connections    nodes/fragment/0/position    nodes/fragment/2/node    nodes/fragment/2/position    nodes/fragment/3/node    nodes/fragment/3/position    nodes/fragment/4/node    nodes/fragment/4/position    nodes/fragment/5/node    nodes/fragment/5/position    nodes/fragment/6/node    nodes/fragment/6/position    nodes/fragment/7/node    nodes/fragment/7/position    nodes/fragment/8/node    nodes/fragment/8/position    nodes/fragment/9/node    nodes/fragment/9/position    nodes/fragment/10/node    nodes/fragment/10/position    nodes/fragment/11/node    nodes/fragment/11/position    nodes/fragment/12/node    nodes/fragment/12/position    nodes/fragment/13/node    nodes/fragment/13/position    nodes/fragment/14/node    nodes/fragment/14/position    nodes/fragment/15/node    nodes/fragment/15/position    nodes/fragment/16/node    nodes/fragment/16/position    nodes/fragment/17/node    nodes/fragment/17/position    nodes/fragment/18/node    nodes/fragment/18/position    nodes/fragment/connections    nodes/light/0/position    nodes/light/connections    nodes/start/0/position    nodes/start/connections    nodes/process/0/position    nodes/process/connections    nodes/collide/0/position    nodes/collide/connections    nodes/start_custom/0/position    nodes/start_custom/connections     nodes/process_custom/0/position !   nodes/process_custom/connections    nodes/sky/0/position    nodes/sky/connections    nodes/fog/0/position    nodes/fog/connections        (   local://VisualShaderNodeBillboard_47r66 �      1   local://VisualShaderNodeTexture2DParameter_qds56 �      &   local://VisualShaderNodeTexture_jeebv >      .   local://VisualShaderNodeVectorDecompose_gq3ct ~      $   local://VisualShaderNodeInput_highc �      '   local://VisualShaderNodeVectorOp_sfjxu       1   local://VisualShaderNodeTexture2DParameter_rglik �      &   local://VisualShaderNodeTexture_oeong �      '   local://VisualShaderNodeVectorOp_jl4lj /      "   local://VisualShaderNodeMix_eyoxl �      -   local://VisualShaderNodeFloatParameter_fyh5p 8      %   local://VisualShaderNodeUVFunc_ja1vj �      ,   local://VisualShaderNodeVec2Parameter_1jqa0 �      $   local://VisualShaderNodeInput_2ohue �      '   local://VisualShaderNodeVectorOp_y5hiw 6      ,   local://VisualShaderNodeVec2Parameter_43r4w �      $   local://VisualShaderNodeInput_bn0fo �      '   local://VisualShaderNodeVectorOp_7cooh *         local://VisualShader_crcat �         VisualShaderNodeBillboard                            #   VisualShaderNodeTexture2DParameter             Fire_Texture          VisualShaderNodeTexture                                 VisualShaderNodeVectorDecompose                                                         VisualShaderNodeInput             color          VisualShaderNodeVectorOp                                                                                        #   VisualShaderNodeTexture2DParameter             Dissolve_Texture          VisualShaderNodeTexture                                VisualShaderNodeVectorOp                                                                                           VisualShaderNodeMix                                                  �?  �?  �?  �?            ?                  VisualShaderNodeFloatParameter             Dissolve_Amount                   VisualShaderNodeUVFunc             VisualShaderNodeVec2Parameter             Dissolve_Speed          VisualShaderNodeInput             time          VisualShaderNodeVectorOp                    
                 
                                       VisualShaderNodeVec2Parameter             Dissolve_Tiling          VisualShaderNodeInput             uv          VisualShaderNodeVectorOp                    
                 
                                       VisualShader )         �  shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_back, diffuse_lambert, specular_schlick_ggx;

uniform sampler2D Fire_Texture;
uniform vec2 Dissolve_Tiling;
uniform vec2 Dissolve_Speed;
uniform sampler2D Dissolve_Texture;
uniform float Dissolve_Amount : hint_range(0, 1);



void vertex() {
	mat4 n_out2p0;
// GetBillboardMatrix:2
	{
		mat4 __wm = mat4(normalize(INV_VIEW_MATRIX[0]), normalize(INV_VIEW_MATRIX[1]), normalize(INV_VIEW_MATRIX[2]), MODEL_MATRIX[3]);
		__wm = __wm * mat4(vec4(cos(INSTANCE_CUSTOM.x), -sin(INSTANCE_CUSTOM.x), 0.0, 0.0), vec4(sin(INSTANCE_CUSTOM.x), cos(INSTANCE_CUSTOM.x), 0.0, 0.0), vec4(0.0, 0.0, 1.0, 0.0), vec4(0.0, 0.0, 0.0, 1.0));
		__wm = __wm * mat4(vec4(length(MODEL_MATRIX[0].xyz), 0.0, 0.0, 0.0), vec4(0.0, length(MODEL_MATRIX[1].xyz), 0.0, 0.0), vec4(0.0, 0.0, length(MODEL_MATRIX[2].xyz), 0.0), vec4(0.0, 0.0, 0.0, 1.0));
		n_out2p0 = VIEW_MATRIX * __wm;
	}


// Output:0
	MODELVIEW_MATRIX = n_out2p0;


}

void fragment() {
// Input:5
	vec4 n_out5p0 = COLOR;


	vec4 n_out3p0;
// Texture2D:3
	n_out3p0 = texture(Fire_Texture, UV);


// Input:17
	vec2 n_out17p0 = UV;


// Vector2Parameter:16
	vec2 n_out16p0 = Dissolve_Tiling;


// VectorOp:18
	vec2 n_out18p0 = n_out17p0 * n_out16p0;


// Input:14
	float n_out14p0 = TIME;


// Vector2Parameter:13
	vec2 n_out13p0 = Dissolve_Speed;


// VectorOp:15
	vec2 n_out15p0 = vec2(n_out14p0) * n_out13p0;


// UVFunc:12
	vec2 n_in12p1 = vec2(1.00000, 1.00000);
	vec2 n_out12p0 = n_out15p0 * n_in12p1 + n_out18p0;


	vec4 n_out8p0;
// Texture2D:8
	n_out8p0 = texture(Dissolve_Texture, n_out12p0);


// VectorOp:9
	vec4 n_out9p0 = n_out3p0 * n_out8p0;


// FloatParameter:11
	float n_out11p0 = Dissolve_Amount;


// Mix:10
	vec4 n_out10p0 = mix(n_out3p0, n_out9p0, n_out11p0);


// VectorOp:6
	vec4 n_out6p0 = n_out5p0 * n_out10p0;


// VectorDecompose:4
	float n_out4p0 = n_out6p0.x;
	float n_out4p1 = n_out6p0.y;
	float n_out4p2 = n_out6p0.z;
	float n_out4p3 = n_out6p0.w;


// Output:0
	ALBEDO = vec3(n_out6p0.xyz);
	ALPHA = n_out4p3;


}
 5             6   
     ��  �C7                     
   8   
     9D  C9            :   
     ��  �B;            <   
     k�  �B=            >   
     �C  \C?            @   
     ��  �BA            B   
     �B  �BC            D   
    ���  zDE            F   
     z�  CDG            H   
     ��  �CI         	   J   
      �  HCK         
   L   
    ���  �CM            N   
     ��  HDO            P   
     ��  DQ            R   
     ��  kDS            T   
     ��  MDU            V   
     ��  CDW            X   
    ���  *DY            Z   
    ���  %D[       L                                                                                            	              	             
       	       
      
                    
                                                                                                           RSRC