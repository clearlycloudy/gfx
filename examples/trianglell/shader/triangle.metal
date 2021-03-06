using namespace metal;

struct VsInput {
  float3 a_Pos [[attribute(0)]];
  float3 a_Color [[attribute(1)]];
};

struct VsOutput {
  float4 pos [[position]];
  float2 uv;
};

vertex VsOutput vs_main(VsInput in [[stage_in]]) {
  VsOutput out;
  out.pos = float4(in.a_Pos, 1.0);
  // Texture coordinates are in OpenGL/Vulkan (origin bottom left)
  // convert them to Metal (origin top left)
  out.uv = float2(in.a_Color.x, 1 - in.a_Color.y);
  return out;
}

fragment float4 ps_main(VsOutput in [[stage_in]], 
                        texture2d<float> tex2D [[ texture(0) ]],
                        sampler sampler2D [[ sampler(0) ]]) {
  return tex2D.sample(sampler2D, in.uv);
}

