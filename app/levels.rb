# Thanks to Justin Cyr on Twitter and computermaus256 on reddit for some of their art!

def rand_rgb()
  return { r: rand(265), g: rand(256), b: rand(256) }
end

def load_levels args
  args.state.first_color ||= rand_rgb()
  args.state.second_color ||= rand_rgb()
  args.state.third_color ||= rand_rgb()
  args.state.fourth_color ||= rand_rgb()
  args.state.fifth_color ||= rand_rgb()
  args.state.sixth_color ||= rand_rgb()
  args.state.seventh_color ||= rand_rgb()
  args.state.eighth_color ||= rand_rgb()
  args.state.ninth_color ||= rand_rgb()
  args.state.tenth_color ||= rand_rgb()
  
  args.state.levels = [
    {
      finished: false,
      content: [
        [ 0, 0, 0, 2, 2, 0, 0, 0 ],
        [ 0, 0, 2, 2, 2, 2, 0, 0 ],
        [ 0, 0, 2, 2, 2, 2, 0, 0 ],
        [ 0, 0, 2, 2, 2, 2, 0, 0 ],
        [ 0, 0, 2, 2, 2, 2, 0, 0 ],
        [ 0, 0, 2, 2, 2, 2, 0, 0 ],
        [ 0, 1, 1, 1, 1, 1, 1, 0 ],
        [ 0, 0, 0, 1, 1, 0, 0, 0 ],
      ],
      palette: [
        { r: 0, g: 0, b: 0 },
        args.state.luck_mode == 1 ? args.state.first_color : { r: 255, g: 255, b: 0 },
        args.state.luck_mode == 1 ? args.state.second_color : { r: 255, g: 255, b: 255 }
      ]
    },
    
    {
      finished: false,
      content: [
        [ 2, 2, 2, 1, 1, 2, 2, 2 ],
        [ 2, 2, 2, 1, 1, 2, 2, 2 ],
        [ 2, 2, 2, 1, 1, 2, 2, 2 ],
        [ 1, 1, 1, 1, 1, 1, 1, 1 ],
        [ 1, 1, 1, 1, 1, 1, 1, 1 ],
        [ 2, 2, 2, 1, 1, 2, 2, 2 ],
        [ 2, 2, 2, 1, 1, 2, 2, 2 ],
        [ 2, 2, 2, 1, 1, 2, 2, 2 ],
      ],
      palette: [
        { r: 0, g: 0, b: 0 },
        args.state.luck_mode == 1 ? args.state.first_color : { r: 255, g: 0, b: 0 },
        args.state.luck_mode == 1 ? args.state.second_color : { r: 255, g: 255, b: 255 },
      ]
    },
    
    {
      finished: false,
      content: [
        [ 3, 2, 1, 2, 2, 2, 2, 3 ],
        [ 3, 2, 2, 2, 2, 1, 2, 3 ],
        [ 3, 2, 2, 1, 2, 2, 2, 3 ],
        [ 4, 3, 2, 2, 2, 2, 3, 4 ],
        [ 5, 4, 3, 3, 3, 3, 4, 5 ],
        [ 0, 5, 4, 4, 4, 4, 5, 0 ],
        [ 0, 0, 0, 0, 0, 0, 0, 0 ],
        [ 0, 0, 0, 0, 0, 0, 0, 0 ],
      ],
      palette: [
        { r: 0, g: 0, b: 0 },
        args.state.luck_mode == 1 ? args.state.first_color : { r: 0, g: 0, b: 0 },
        args.state.luck_mode == 1 ? args.state.second_color : { r: 255, g: 0, b: 77 },
        args.state.luck_mode == 1 ? args.state.third_color : { r: 255, g: 243, b: 232 },
        args.state.luck_mode == 1 ? args.state.fourth_color : { r: 0, g: 231, b: 66 },
        args.state.luck_mode == 1 ? args.state.fifth_color : { r: 0, g: 135, b: 81 },
      ]
    },
    
    {
      finished: false,
      content: [
        [ 0, 1, 1, 1, 1, 1, 1, 0 ],
        [ 1, 2, 3, 2, 2, 3, 2, 1 ],
        [ 1, 2, 1, 4, 4, 1, 3, 1 ],
        [ 1, 3, 2, 2, 3, 2, 2, 1 ],
        [ 5, 1, 1, 1, 1, 1, 1, 5 ],
        [ 5, 5, 5, 5, 5, 5, 5, 5 ],
        [ 5, 5, 6, 6, 6, 6, 6, 5 ],
        [ 0, 5, 5, 6, 6, 6, 5, 0 ],
      ],
      palette: [
        { r: 0, g: 0, b: 0 },
        args.state.luck_mode == 1 ? args.state.first_color : { r: 0, g: 231, b: 86 },
        args.state.luck_mode == 1 ? args.state.second_color : { r: 0, g: 135, b: 81 },
        args.state.luck_mode == 1 ? args.state.third_color : { r: 0, g: 0, b: 0 },
        args.state.luck_mode == 1 ? args.state.fourth_color : { r: 255, g: 241, b: 232 },
        args.state.luck_mode == 1 ? args.state.fifth_color : { r: 126, g: 37, b: 83 },
        args.state.luck_mode == 1 ? args.state.sixth_color : { r: 171, g: 82, b: 54 }
      ]
    },
    
    {
      finished: false,
      content: [
        [ 2, 1, 1, 3, 2, 1, 1, 3 ],
        [ 2, 2, 2, 3, 2, 2, 2, 3 ],
        [ 3, 3, 3, 0, 3, 3, 3, 0 ],
        [ 2, 1, 1, 3, 2, 1, 1, 3 ],
        [ 2, 2, 2, 3, 2, 2, 2, 3 ],
        [ 3, 3, 3, 0, 3, 3, 3, 0 ],
        [ 2, 1, 1, 3, 2, 1, 1, 3 ],
        [ 2, 2, 2, 3, 2, 2, 2, 3 ],
      ],
      palette: [
        { r: 0, g: 0, b: 0 },
        args.state.luck_mode == 1 ? args.state.first_color : { r: 255, g: 163, b: 0 },
        args.state.luck_mode == 1 ? args.state.second_color : { r: 171, g: 82, b: 54 },
        args.state.luck_mode == 1 ? args.state.third_color : { r: 126, g: 37, b: 83 },
      ]
    },
    
    {
      finished: false,
      content: [
        [ 0, 0, 0, 4, 0, 0, 0, 0 ],
        [ 0, 0, 0, 4, 4, 0, 4, 0 ],
        [ 0, 0, 0, 3, 2, 0, 4, 4 ],
        [ 0, 0, 2, 1, 1, 2, 3, 0 ],
        [ 0, 2, 1, 1, 1, 2, 1, 0 ],
        [ 0, 1, 2, 1, 1, 1, 1, 0 ],
        [ 1, 1, 2, 1, 2, 1, 1, 0 ],
        [ 1, 1, 2, 1, 1, 2, 0, 0 ],
      ],
      palette: [
        { r: 0, g: 0, b: 0 },
        args.state.luck_mode == 1 ? args.state.first_color : { r: 171, g: 82, b: 54 },
        args.state.luck_mode == 1 ? args.state.second_color : { r: 126, g: 37, b: 83 },
        args.state.luck_mode == 1 ? args.state.third_color : { r: 255, g: 204, b: 170 },
        args.state.luck_mode == 1 ? args.state.fourth_color : { r: 255, g: 241, b: 232 },
      ]
    },
    
    {
      finished: false,
      content: [
        [ 0, 1, 2, 1, 1, 2, 1, 0 ],
        [ 2, 1, 1, 1, 1, 1, 1, 2 ],
        [ 2, 1, 2, 1, 1, 2, 1, 2 ],
        [ 2, 1, 1, 1, 1, 1, 1, 2 ],
        [ 4, 2, 2, 2, 2, 2, 2, 4 ],
        [ 4, 3, 3, 3, 3, 3, 3, 4 ],
        [ 1, 3, 3, 3, 3, 3, 3, 1 ],
        [ 2, 2, 2, 2, 2, 2, 2, 2 ],
      ],
      palette: [
        { r: 0, g: 0, b: 0 },
        args.state.luck_mode == 1 ? args.state.first_color : { r: 171, g: 82, b: 54 },
        args.state.luck_mode == 1 ? args.state.second_color : { r: 126, g: 37, b: 83 },
        args.state.luck_mode == 1 ? args.state.third_color : { r: 255, g: 241, b: 232 },
        args.state.luck_mode == 1 ? args.state.fourth_color : { r: 194, g: 195, b: 199 },
      ]
    },
    
    {
      finished: false,
      content: [
        [ 0, 0, 0, 0, 3, 3, 3, 0 ],
        [ 0, 0, 0, 3, 0, 3, 0, 0 ],
        [ 0, 0, 3, 0, 0, 3, 0, 0 ],
        [ 0, 0, 3, 0, 0, 1, 1, 0 ],
        [ 0, 1, 1, 0, 1, 1, 2, 1 ],
        [ 1, 1, 2, 1, 0, 1, 1, 1 ],
        [ 1, 1, 1, 1, 0, 1, 1, 0 ],
        [ 0, 1, 1, 0, 0, 0, 0, 0 ],
      ],
      palette: [
        { r: 0, g: 0, b: 0 },
        args.state.luck_mode == 1 ? args.state.first_color : { r: 255, g: 0, b: 77 },
        args.state.luck_mode == 1 ? args.state.second_color : { r: 255, g: 241, b: 232 },
        args.state.luck_mode == 1 ? args.state.third_color : { r: 0, g: 231, b: 86 },
      ]
    },
    
    {
      finished: false,
      content: [
        [ 0, 0, 0, 0, 0, 4, 0, 0 ],
        [ 0, 1, 1, 1, 4, 1, 1, 0 ],
        [ 1, 3, 2, 1, 1, 1, 1, 1 ],
        [ 1, 2, 1, 1, 1, 1, 1, 1 ],
        [ 1, 1, 1, 1, 1, 1, 1, 1 ],
        [ 1, 1, 1, 1, 1, 1, 1, 1 ],
        [ 0, 1, 1, 1, 1, 1, 1, 0 ],
        [ 0, 0, 1, 1, 1, 1, 0, 0 ],
      ],
      palette: [
        { r: 0, g: 0, b: 0 },
        args.state.luck_mode == 1 ? args.state.first_color : { r: 255, g: 0, b: 77 },
        args.state.luck_mode == 1 ? args.state.second_color : { r: 255, g: 119, b: 186 },
        args.state.luck_mode == 1 ? args.state.third_color : { r: 255, g: 241, b: 232 },
        args.state.luck_mode == 1 ? args.state.fourth_color : { r: 0, g: 231, b: 86 },
      ]
    },
    
    {
      finished: false,
      content: [
        [ 0, 0, 0, 0, 4, 0, 0, 0 ],
        [ 0, 0, 0, 0, 0, 4, 0, 0 ],
        [ 0, 0, 0, 0, 0, 4, 4, 0 ],
        [ 0, 0, 0, 0, 1, 1, 1, 0 ],
        [ 0, 0, 0, 1, 2, 1, 1, 0 ],
        [ 0, 0, 1, 2, 1, 1, 3, 0 ],
        [ 1, 1, 1, 1, 1, 3, 0, 0 ],
        [ 0, 3, 3, 3, 3, 0, 0, 0 ],
      ],
      palette: [
        { r: 0, g: 0, b: 0 },
        args.state.luck_mode == 1 ? args.state.first_color : { r: 255, g: 0, b: 77 },
        args.state.luck_mode == 1 ? args.state.second_color : { r: 255, g: 119, b: 186 },
        args.state.luck_mode == 1 ? args.state.third_color : { r: 126, g: 37, b: 83 },
        args.state.luck_mode == 1 ? args.state.fourth_color : { r: 0, g: 231, b: 86 },
      ]
    },
    
    {
      finished: false,
      content: [
        [ 0, 0, 1, 1, 1, 1, 0, 0 ],
        [ 0, 1, 1, 1, 1, 1, 1, 0 ],
        [ 0, 1, 1, 1, 1, 1, 1, 0 ],
        [ 1, 1, 3, 2, 2, 3, 1, 1 ],
        [ 1, 1, 2, 2, 2, 2, 1, 1 ],
        [ 1, 1, 2, 2, 2, 2, 1, 1 ],
        [ 0, 1, 3, 2, 2, 3, 1, 0 ],
        [ 0, 0, 1, 1, 1, 1, 0, 0 ],
      ],
      palette: [
        { r: 0, g: 0, b: 0 },
        args.state.luck_mode == 1 ? args.state.first_color : { r: 255, g: 241, b: 232 },
        args.state.luck_mode == 1 ? args.state.second_color : { r: 255, g: 163, b: 0 },
        args.state.luck_mode == 1 ? args.state.third_color : { r: 255, g: 255, b: 39 }
      ]
    },
    
    {
      finished: false,
      content: [
        [ 0, 0, 0, 3, 3, 0, 0, 0 ],
        [ 0, 0, 3, 3, 3, 3, 0, 0 ],
        [ 0, 3, 3, 3, 3, 1, 1, 0 ],
        [ 0, 3, 3, 1, 1, 1, 1, 0 ],
        [ 0, 1, 1, 1, 1, 1, 1, 0 ],
        [ 0, 2, 2, 2, 2, 2, 2, 0 ],
        [ 0, 0, 1, 1, 1, 1, 0, 0 ],
        [ 0, 0, 2, 2, 2, 2, 0, 0 ],
      ],
      palette: [
        { r: 0, g: 0, b: 0 },
        args.state.luck_mode == 1 ? args.state.first_color : { r: 171, g: 82, b: 54 },
        args.state.luck_mode == 1 ? args.state.second_color : { r: 255, g: 163, b: 0 },
        args.state.luck_mode == 1 ? args.state.third_color : { r: 255, g: 241, b: 232 },
      ]
    },
    
    {
      finished: false,
      content: [
        [ 1, 3, 3, 3, 3, 3, 3, 1 ],
        [ 1, 2, 1, 2, 2, 2, 2, 1 ],
        [ 1, 2, 1, 2, 2, 2, 2, 1 ],
        [ 1, 2, 2, 2, 2, 2, 2, 1 ],
        [ 0, 1, 3, 3, 3, 3, 1, 0 ],
        [ 0, 0, 1, 3, 3, 1, 0, 0 ],
        [ 0, 0, 0, 1, 1, 0, 0, 0 ],
        [ 0, 0, 1, 1, 1, 1, 0, 0 ],
      ],
      palette: [
        { r: 0, g: 0, b: 0 },
        args.state.luck_mode == 1 ? args.state.first_color : { r: 255, g: 241, b: 232 },
        args.state.luck_mode == 1 ? args.state.second_color : { r: 255, g: 0, b: 77 },
        args.state.luck_mode == 1 ? args.state.third_color : { r: 126, g: 37, b: 83 },
      ]
    },
    
    {
      finished: false,
      content: [
        [ 1, 1, 1, 1, 1, 1, 0, 0 ],
        [ 1, 1, 1, 1, 1, 3, 1, 1 ],
        [ 1, 1, 1, 1, 1, 2, 0, 1 ],
        [ 1, 1, 1, 1, 1, 2, 0, 1 ],
        [ 1, 1, 1, 1, 1, 2, 0, 1 ],
        [ 1, 1, 1, 1, 1, 3, 1, 0 ],
        [ 2, 1, 1, 1, 2, 2, 0, 0 ],
        [ 3, 2, 2, 2, 2, 3, 0, 0 ],
      ],
      palette: [
        { r: 0, g: 0, b: 0 },
        args.state.luck_mode == 1 ? args.state.first_color : { r: 255, g: 241, b: 232 },
        args.state.luck_mode == 1 ? args.state.second_color : { r: 194, g: 195, b: 199 },
        args.state.luck_mode == 1 ? args.state.third_color : { r: 131, g: 118, b: 156 },
      ]
    },
    
    {
      finished: false,
      content: [
        [ 1, 1, 1, 1, 1, 1, 0, 0 ],
        [ 1, 1, 1, 1, 1, 1, 1, 1 ],
        [ 1, 1, 1, 1, 1, 1, 0, 1 ],
        [ 1, 1, 1, 1, 1, 1, 1, 0 ],
        [ 3, 1, 1, 1, 1, 3, 0, 0 ],
        [ 0, 3, 2, 2, 3, 0, 0, 0 ],
        [ 1, 1, 1, 1, 1, 1, 0, 0 ],
        [ 0, 0, 0, 0, 0, 0, 0, 0 ],
      ],
      palette: [
        { r: 0, g: 0, b: 0 },
        args.state.luck_mode == 1 ? args.state.first_color : { r: 255, g: 241, b: 232 },
        args.state.luck_mode == 1 ? args.state.second_color : { r: 194, g: 195, b: 199 },
        args.state.luck_mode == 1 ? args.state.third_color : { r: 131, g: 118, b: 156 },
      ]
    },
    
    {
      finished: false,
      content: [
        [ 0, 1, 2, 2, 2, 2, 1, 0 ],
        [ 0, 1, 2, 2, 3, 2, 1, 0 ],
        [ 0, 1, 3, 2, 2, 2, 1, 0 ],
        [ 0, 1, 2, 2, 3, 2, 1, 0 ],
        [ 0, 1, 2, 2, 2, 2, 1, 0 ],
        [ 0, 1, 2, 2, 2, 2, 1, 0 ],
        [ 0, 1, 2, 2, 2, 2, 1, 0 ],
        [ 0, 4, 1, 1, 1, 1, 4, 0 ],
      ],
      palette: [
        { r: 0, g: 0, b: 0 },
        args.state.luck_mode == 1 ? args.state.first_color : { r: 255, g: 241, b: 232 },
        args.state.luck_mode == 1 ? args.state.second_color : { r: 255, g: 163, b: 0 },
        args.state.luck_mode == 1 ? args.state.third_color : { r: 255, g: 255, b: 39 },
        args.state.luck_mode == 1 ? args.state.fourth_color : { r: 131, g: 118, b: 156 },
      ]
    },
    
    {
      finished: false,
      content: [
        [ 0, 0, 0, 1, 3, 0, 0, 0 ],
        [ 0, 0, 1, 1, 3, 3, 0, 0 ],
        [ 0, 1, 1, 1, 3, 3, 3, 0 ],
        [ 1, 1, 1, 1, 3, 3, 3, 3 ],
        [ 3, 3, 3, 3, 2, 2, 2, 2 ],
        [ 0, 3, 3, 3, 2, 2, 2, 0 ],
        [ 0, 0, 3, 3, 2, 2, 0, 0 ],
        [ 0, 0, 0, 3, 2, 0, 0, 0 ],
      ],
      palette: [
        { r: 0, g: 0, b: 0 },
        args.state.luck_mode == 1 ? args.state.first_color : { r: 255, g: 241, b: 232 },
        args.state.luck_mode == 1 ? args.state.second_color : { r: 131, g: 118, b: 156 },
        args.state.luck_mode == 1 ? args.state.third_color : { r: 41, g: 173, b: 255 },
      ]
    },
    
    {
      finished: false,
      content: [
        [ 0, 0, 1, 1, 1, 1, 0, 0 ],
        [ 0, 0, 0, 2, 2, 0, 0, 0 ],
        [ 0, 0, 0, 1, 1, 0, 0, 0 ],
        [ 0, 0, 1, 3, 3, 1, 0, 0 ],
        [ 0, 1, 4, 4, 4, 4, 1, 0 ],
        [ 0, 1, 4, 4, 4, 4, 1, 0 ],
        [ 0, 3, 4, 4, 4, 4, 3, 0 ],
        [ 0, 0, 3, 3, 3, 3, 0, 0 ],
      ],
      palette: [
        { r: 0, g: 0, b: 0 },
        args.state.luck_mode == 1 ? args.state.first_color : { r: 255, g: 241, b: 232 },
        args.state.luck_mode == 1 ? args.state.second_color : { r: 194, g: 195, b: 199 },
        args.state.luck_mode == 1 ? args.state.third_color : { r: 131, g: 118, b: 156 },
        args.state.luck_mode == 1 ? args.state.fourth_color : { r: 41, g: 173, b: 255 },
      ]
    },
    
    {
      finished: false,
      content: [
        [ 0, 0, 0, 1, 1, 0, 0, 0 ],
        [ 0, 0, 1, 1, 1, 1, 0, 0 ],
        [ 0, 0, 1, 2, 2, 1, 0, 0 ],
        [ 0, 0, 1, 2, 2, 1, 0, 0 ],
        [ 0, 0, 1, 2, 2, 1, 0, 0 ],
        [ 0, 0, 1, 2, 2, 1, 0, 0 ],
        [ 0, 0, 1, 2, 2, 1, 0, 0 ],
        [ 0, 0, 1, 1, 1, 1, 0, 0 ],
      ],
      palette: [
        { r: 0, g: 0, b: 0 },
        args.state.luck_mode == 1 ? args.state.first_color : { r: 0, g: 0, b: 0 },
        args.state.luck_mode == 1 ? args.state.second_color : { r: 0, g: 231, b: 86 },
      ]
    },
    
    {
      finished: false,
      content: [
        [ 0, 0, 0, 0, 1, 1, 1, 1 ],
        [ 0, 0, 1, 1, 1, 1, 1, 1 ],
        [ 1, 1, 1, 1, 1, 1, 1, 1 ],
        [ 2, 2, 2, 2, 2, 2, 2, 2 ],
        [ 2, 2, 2, 2, 2, 2, 2, 2 ],
        [ 1, 1, 1, 1, 1, 1, 1, 1 ],
        [ 2, 2, 2, 2, 2, 2, 2, 2 ],
        [ 2, 2, 2, 2, 2, 2, 2, 2 ],
      ],
      palette: [
        { r: 0, g: 0, b: 0 },
        args.state.luck_mode == 1 ? args.state.first_color : { r: 63, g: 39, b: 52 },
        args.state.luck_mode == 1 ? args.state.second_color : { r: 199, g: 131, b: 108 },
      ]
    },
    
    {
      finished: false,
      content: [
        [ 0, 0, 2, 2, 0, 0, 0, 0 ],
        [ 0, 2, 1, 1, 2, 0, 0, 0 ],
        [ 2, 1, 1, 2, 2, 2, 0, 0 ],
        [ 2, 1, 1, 2, 1, 1, 2, 0 ],
        [ 0, 2, 1, 1, 2, 1, 1, 2 ],
        [ 0, 0, 2, 2, 2, 1, 1, 2 ],
        [ 0, 0, 0, 2, 1, 1, 2, 0 ],
        [ 0, 0, 0, 0, 2, 2, 0, 0 ],
      ],
      palette: [
        { r: 0, g: 0, b: 0 },
        args.state.luck_mode == 1 ? args.state.first_color : { r: 0, g: 231, b: 86 },
        args.state.luck_mode == 1 ? args.state.second_color : { r: 0, g: 135, b: 81 },
      ]
    },
    
    {
      finished: false,
      content: [
        [ 0, 0, 0, 0, 3, 3, 3, 3 ],
        [ 0, 0, 0, 3, 4, 0, 2, 0 ],
        [ 0, 0, 3, 4, 0, 0, 1, 0 ],
        [ 0, 0, 3, 4, 0, 0, 1, 0 ],
        [ 0, 0, 3, 4, 0, 0, 1, 0 ],
        [ 0, 0, 0, 3, 4, 0, 2, 0 ],
        [ 0, 0, 0, 0, 3, 3, 3, 3 ],
        [ 0, 0, 0, 0, 0, 0, 0, 0 ],
      ],
      palette: [
        { r: 0, g: 0, b: 0 },
        args.state.luck_mode == 1 ? args.state.first_color : { r: 255, g: 241, b: 232 },
        args.state.luck_mode == 1 ? args.state.second_color : { r: 194, g: 195, b: 199 },
        args.state.luck_mode == 1 ? args.state.third_color : { r: 171, g: 82, b: 54 },
        args.state.luck_mode == 1 ? args.state.fourth_color : { r: 126, g: 37, b: 83 },
      ]
    },
    
    {
      finished: false,
      content: [
        [ 0, 0, 0, 1, 0, 0, 0, 0 ],
        [ 0, 0, 0, 1, 1, 0, 0, 0 ],
        [ 0, 0, 0, 1, 0, 1, 0, 0 ],
        [ 0, 0, 0, 1, 0, 0, 0, 0 ],
        [ 0, 0, 0, 1, 0, 0, 0, 0 ],
        [ 0, 0, 1, 1, 0, 0, 0, 0 ],
        [ 0, 1, 1, 1, 0, 0, 0, 0 ],
        [ 0, 1, 1, 0, 0, 0, 0, 0 ],
      ],
      palette: [
        { r: 0, g: 0, b: 0 },
        args.state.luck_mode == 1 ? args.state.first_color : { r: 41, g: 173, b: 255 },
      ]
    },
    
    {
      finished: false,
      content: [
        [ 0, 0, 1, 1, 1, 1, 0, 0 ],
        [ 0, 0, 1, 0, 0, 1, 0, 0 ],
        [ 0, 0, 1, 0, 0, 1, 0, 0 ],
        [ 0, 0, 1, 1, 1, 1, 0, 0 ],
        [ 0, 0, 0, 1, 1, 0, 0, 0 ],
        [ 0, 0, 0, 1, 1, 1, 0, 0 ],
        [ 0, 0, 0, 1, 1, 0, 0, 0 ],
        [ 0, 0, 0, 1, 1, 1, 0, 0 ],
      ],
      palette: [
        { r: 0, g: 0, b: 0 },
        args.state.luck_mode == 1 ? args.state.first_color : { r: 255, g: 255, b: 0 }
      ]
    },
    
    {
      finished: false,
      content: [
        [ 2, 2, 2, 2, 2, 2, 2, 2 ],
        [ 2, 2, 1, 1, 1, 1, 2, 2 ],
        [ 2, 1, 2, 1, 1, 2, 1, 2 ],
        [ 2, 1, 1, 2, 2, 1, 1, 2 ],
        [ 2, 1, 1, 2, 2, 1, 1, 2 ],
        [ 2, 1, 2, 1, 1, 2, 1, 2 ],
        [ 2, 2, 1, 1, 1, 1, 2, 2 ],
        [ 2, 2, 2, 2, 2, 2, 2, 2 ],
      ],
      palette: [
        { r: 0, g: 0, b: 0 },
        args.state.luck_mode == 1 ? args.state.first_color : { r: 199, g: 131, b: 108 },
        args.state.luck_mode == 1 ? args.state.second_color : { r: 63, g: 39, b: 52 },
      ]
    },
    
    {
      finished: false,
      content: [
        [ 0, 2, 2, 0, 0, 2, 2, 0 ],
        [ 2, 1, 1, 2, 2, 1, 1, 2 ],
        [ 2, 1, 1, 1, 1, 1, 1, 2 ],
        [ 2, 1, 1, 1, 1, 1, 1, 2 ],
        [ 2, 1, 1, 1, 1, 1, 1, 2 ],
        [ 0, 2, 1, 1, 1, 1, 2, 0 ],
        [ 0, 0, 2, 1, 1, 2, 0, 0 ],
        [ 0, 0, 0, 2, 2, 0, 0, 0 ],
      ],
      palette: [
        { r: 0, g: 0, b: 0 },
        args.state.luck_mode == 1 ? args.state.first_color : { r: 255, g: 0, b: 77 },
        args.state.luck_mode == 1 ? args.state.second_color : { r: 126, g: 37, b: 83 },
      ]
    },
    
    {
      finished: false,
      content: [
        [ 0, 4, 4, 4, 4, 4, 4, 0 ],
        [ 4, 3, 3, 2, 2, 3, 3, 4 ],
        [ 4, 3, 3, 2, 2, 3, 3, 4 ],
        [ 4, 3, 3, 1, 1, 3, 3, 4 ],
        [ 4, 3, 3, 1, 1, 3, 3, 4 ],
        [ 4, 3, 3, 3, 3, 3, 3, 4 ],
        [ 4, 3, 3, 3, 3, 3, 3, 4 ],
        [ 0, 4, 4, 4, 4, 4, 4, 0 ],
      ],
      palette: [
        { r: 0, g: 0, b: 0 },
        args.state.luck_mode == 1 ? args.state.first_color : { r: 0, g: 0, b: 0 },
        args.state.luck_mode == 1 ? args.state.second_color : { r: 255, g: 0, b: 0 },
        args.state.luck_mode == 1 ? args.state.third_color : { r: 255, g: 241, b: 232 },
        args.state.luck_mode == 1 ? args.state.fourth_color : { r: 194, g: 195, b: 199 },
      ]
    },
    
    {
      finished: false,
      content: [
        [ 0, 0, 0, 0, 0, 0, 0, 0 ],
        [ 0, 0, 0, 0, 0, 0, 0, 0 ],
        [ 0, 0, 0, 0, 0, 0, 0, 0 ],
        [ 0, 0, 0, 0, 0, 0, 0, 0 ],
        [ 0, 0, 0, 1, 1, 0, 0, 0 ],
        [ 0, 0, 1, 1, 1, 1, 0, 0 ],
        [ 0, 1, 1, 2, 2, 1, 1, 0 ],
        [ 1, 1, 1, 2, 2, 1, 1, 1 ],
      ],
      palette: [
        { r: 0, g: 0, b: 0 },
        args.state.luck_mode == 1 ? args.state.first_color : { r: 171, g: 82, b: 54 },
        args.state.luck_mode == 1 ? args.state.second_color : { r: 0, g: 0, b: 0 }
      ]
    },
    
    {
      finished: false,
      content: [
        [ 0, 0, 2, 2, 2, 2, 0, 0 ],
        [ 0, 0, 1, 1, 1, 1, 0, 0 ],
        [ 0, 0, 1, 1, 1, 1, 0, 0 ],
        [ 0, 0, 1, 1, 1, 1, 0, 0 ],
        [ 0, 0, 1, 1, 1, 1, 0, 0 ],
        [ 0, 0, 1, 1, 1, 1, 1, 1 ],
        [ 0, 0, 1, 1, 1, 1, 1, 1 ],
        [ 0, 0, 2, 2, 2, 2, 2, 2 ],
      ],
      palette: [
        { r: 0, g: 0, b: 0 },
        args.state.luck_mode == 1 ? args.state.first_color : { r: 255, g: 0, b: 0 },
        args.state.luck_mode == 1 ? args.state.second_color : { r: 255, g: 255, b: 255 },
      ]
    },
    
    {
      finished: false,
      content: [
        [ 0, 0, 1, 1, 1, 1, 2, 0 ],
        [ 0, 1, 1, 1, 1, 1, 1, 2 ],
        [ 1, 1, 1, 1, 2, 0, 0, 0 ],
        [ 1, 1, 1, 2, 0, 0, 0, 0 ],
        [ 1, 1, 1, 2, 0, 0, 0, 0 ],
        [ 1, 1, 1, 1, 2, 0, 0, 0 ],
        [ 0, 1, 1, 1, 1, 1, 1, 2 ],
        [ 0, 0, 1, 1, 1, 1, 2, 0 ],
      ],
      palette: [
        { r: 0, g: 0, b: 0 },
        args.state.luck_mode == 1 ? args.state.first_color : { r: 245, g: 247, b: 249 },
        args.state.luck_mode == 1 ? args.state.second_color : { r: 200, g: 200, b: 200 }
      ]
    },
    
    {
      finished: false,
      content: [
        [ 0, 0, 2, 2, 2, 2, 0, 0 ],
        [ 0, 2, 3, 2, 2, 2, 2, 0 ],
        [ 2, 3, 2, 2, 2, 2, 2, 2 ],
        [ 2, 2, 2, 2, 2, 2, 2, 2 ],
        [ 0, 0, 0, 0, 1, 0, 0, 0 ],
        [ 0, 0, 0, 0, 1, 0, 0, 0 ],
        [ 0, 0, 1, 0, 1, 0, 0, 0 ],
        [ 0, 0, 0, 1, 0, 0, 0, 0 ],
      ],
      palette: [
        { r: 0, g: 0, b: 0 },
        args.state.luck_mode == 1 ? args.state.first_color : { r: 243, g: 180, b: 6 },
        args.state.luck_mode == 1 ? args.state.second_color : { r: 255, g: 0, b: 0 },
        args.state.luck_mode == 1 ? args.state.third_color : { r: 255, g: 255, b: 255 }
      ]
    },
    
  ]
end
