# Written by Rabia Alhaffar in 4/May/2021
# Updated: 5/May/2021
# luckpaint, Hybrid paint game made for Juicy Jam #1
# Thanks also goes to @leviondiscord and @Vote Pedro and @Akzidenz-Grotesk at DragonRuby Discord Server for helping me!

require "app/levels.rb"     # Load game levels

# Detects collision between 2 rectangles...
def AABB(x1, y1, w1, h1, x2, y2, w2, h2)
  return x1 < x2 + w2 && x1 + w1 > x2 && y1 < y2 + h2 && y1 + h1 > y2
end

# Detects if array matches with another in length and elements
def arr_match(arr1, arr2)
  if arr1.length != arr2.length
    return false
  else
    matches = 0
    
    arr1.length.times.map do |i|
      if arr1[i] == arr2[i]
        matches += 1
      end
    end
    
    return matches == arr1.length
  end
end

# Just made here for being used mostly everywhere in the game (So to not repeat same stuff)
def play_click_sound args
  if args.state.sound_enabled == 1
    args.audio[:click] ||= {
      input: "audio/399934__old-waveplay__perc-short-click-snap-perc.wav",
      x: 0.0,
      y: 0.0,
      z: 0.0,
      gain: args.state.volume / 100,
      pitch: 1.0,
      paused: false,
      looping: false,
    }
  end
end

# Game loop
def tick args
  setup args
  load_levels args
  
  if !args.state.game_loaded
    parsed_state = $gtk.deserialize_state("game_state.txt")
  
    if parsed_state
      $gtk.args.state = parsed_state
      args.state.current_scene = 0
      args.state.loaded_saved_game = true
      
      if args.state.loaded_saved_game && args.state.current_level > 0
        args.state.played_game_previously = 1
      end
    end
    
    args.state.game_loaded = true
  end
  
  if args.state.fullscreen == 1
    $gtk.set_window_fullscreen true
  else
    $gtk.set_window_fullscreen false
  end
  
  $gtk.hide_cursor
  
  if args.state.current_scene == 0
    main_menu args
  elsif args.state.current_scene == 1    
    select_mode_menu args
  elsif args.state.current_scene == 2
    play_game args
  elsif args.state.current_scene == 3
    pause_menu args
  elsif args.state.current_scene == 4
    options_menu args
  elsif args.state.current_scene == 5
    credits_menu args
  end
  
  if args.state.current_scene != 1 && args.state.current_scene != 2 && args.state.current_scene != 3
    args.outputs.primitives << {
      x: 1280 - 84,
      y: 700.from_top,
      w: 64,
      h: 64,
      path: "sprites/icon.png"
    }.sprite
    
    if args.inputs.mouse.click && args.inputs.mouse.button_left
      if AABB(args.inputs.mouse.x, args.inputs.mouse.y, 1, 1, 1280 - 84, 700.from_top, 64, 64)
        $gtk.openurl "https://dragonruby.org"
      end
    end
  end
  
  args.outputs.primitives << {
    x: args.inputs.mouse.x - 60,
    y: args.inputs.mouse.y - 14,
    w: 128,
    h: 128,
    path: "sprites/cursor.png"
  }.sprite
  
  # ESC: Exit game
  if args.inputs.keyboard.key_down.escape
    if args.state.current_scene == 0
      $gtk.exit
    else
      if args.state.current_scene != 2
        args.state.current_scene = 0
      else
        args.state.current_scene = 3
      end
    end
  end
  
  # R key: Restart game
  if args.inputs.keyboard.tab || args.inputs.keyboard.r
    $gtk.reset seed: (Time.now.to_f * 100).to_i
  end
  
  # S key: Screenshot
  if args.inputs.keyboard.key_down.s
    take_screenshot args
  end
end

def take_screenshot args
  if !File.exist?("screenshots/")
    $gtk.system "mkdir screenshots/"
  end
  
  if File.file?("screenshots/screenshot#{args.state.screenshot_index}.png")
    args.state.screenshot_index += 1
  end
  
  args.outputs.screenshots << {
    x: 0,
    y: 0,
    w: 1280,
    h: 720,
    path: "screenshots/screenshot#{args.state.screenshot_index}.png",
    r: 255,
    g: 255,
    b: 255,
    a: 255
  }
end

def setup args
  args.state.game_loaded            ||= false
  args.state.loaded_saved_game      ||= false
  args.state.painting               ||= false
  args.state.played_game_previously ||= 0
  args.state.luck_mode              ||= 0
  args.state.sound_enabled          ||= 1
  args.state.music_enabled          ||= 1
  args.state.volume                 ||= 100
  args.state.fullscreen             ||= 0
  args.state.trail_x                ||= 0
  args.state.trail_y                ||= 0
  args.state.trail_w                ||= 0
  args.state.current_scene          ||= 0
  args.state.selected_color         ||= 0
  args.state.current_level          ||= 0
  args.state.line_width_timer       ||= 0
  args.state.clear_data_timer       ||= 0
  args.state.data_cleared           ||= 0
  args.state.paint_finish_timer     ||= 0
  args.state.selection              ||= -1
  args.state.prev_selection         ||= -1
  args.state.painting_alpha         ||= 255
  args.state.screenshot_index       ||= 0
  
  args.state.menu_texts ||= [
    {
      text: "START NEW GAME",
      x: 32,
      y: 460.from_top,
      trail_w: 0
    },
    {
      text: "OPTIONS",
      x: 32,
      y: 520.from_top,
      trail_w: 0
    },
    {
      text: "CREDITS",
      x: 32,
      y: 580.from_top,
      trail_w: 0
    },
    {
      text: "EXIT",
      x: 32,
      y: 640.from_top,
      trail_w: 0
    },
  ]
  
  args.state.current_grid ||= [
    [ 0, 0, 0, 0, 0, 0, 0, 0 ],
    [ 0, 0, 0, 0, 0, 0, 0, 0 ],
    [ 0, 0, 0, 0, 0, 0, 0, 0 ],
    [ 0, 0, 0, 0, 0, 0, 0, 0 ],
    [ 0, 0, 0, 0, 0, 0, 0, 0 ],
    [ 0, 0, 0, 0, 0, 0, 0, 0 ],
    [ 0, 0, 0, 0, 0, 0, 0, 0 ],
    [ 0, 0, 0, 0, 0, 0, 0, 0 ],
  ]
  
  args.state.keys = [
    args.inputs.keyboard.key_down.zero,
    args.inputs.keyboard.key_down.one,
    args.inputs.keyboard.key_down.two,
    args.inputs.keyboard.key_down.three,
    args.inputs.keyboard.key_down.four,
    args.inputs.keyboard.key_down.five,
    args.inputs.keyboard.key_down.six,
    args.inputs.keyboard.key_down.seven,
    args.inputs.keyboard.key_down.eight,
    args.inputs.keyboard.key_down.nine,
  ]
end

def main_menu args
  if args.state.loaded_saved_game && (args.state.current_level >= 0 && args.state.played_game_previously == 1)
    args.state.menu_texts[0].text = "CONTINUE"
  else
    args.state.menu_texts[0].text = "START NEW GAME"
  end
  
  args.outputs.primitives << {
    x: 0,
    y: 760.from_top,
    w: 1280,
    h: 760,
    path: "sprites/background.jpg"
  }.sprite
  
  args.outputs.primitives << {
    x: 416,
    y: 32.from_top,
    text: "LUCKPAINT",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 48,
    r: 255,
    g: 0,
    b: 200,
    a: 255,
  }.label
  
  args.outputs.primitives << {
    x: 632,
    y: 142.from_top,
    text: "BY RABIA ALHAFFAR",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 6,
    r: 255,
    g: 0,
    b: 200,
    a: 255
  }.label
  
  args.state.menu_texts.length.times.map do |i|
    args.outputs.primitives << {
      x: args.state.menu_texts[i].x,
      y: args.state.menu_texts[i].y,
      text: args.state.menu_texts[i].text,
      font: "fonts/ubuntu-title.ttf",
      size_enum: 16,
      r: 255,
      g: 0,
      b: 255,
      a: 255
    }.label
    
    if AABB(args.inputs.mouse.x - 14, (args.inputs.mouse.y + 320), 1, 1, args.state.menu_texts[i].x, args.state.menu_texts[i].y, 200, 320)
      args.state.prev_selection = args.state.selection
      args.state.selection = i
      
      args.state.trail_x = args.state.menu_texts[i].x
      args.state.trail_y = args.state.menu_texts[i].y - 60
      
      if args.state.menu_texts[args.state.selection][:trail_w] + 5 <= 400
        args.state.menu_texts[args.state.selection][:trail_w] += 5
      end
      
      if args.state.menu_texts[args.state.selection][:trail_w] + 20 > 400
        args.state.line_width_timer += 1
        
        if args.state.line_width_timer == 120
          args.state.line_width_timer = 0
          args.state.menu_texts[args.state.selection][:trail_w] = 0
        end
      end
      
      if args.inputs.mouse.click && args.inputs.mouse.button_left
        if args.state.selection == 0
          play_click_sound args
          if args.state.played_game_previously == 0
            args.state.current_scene = 1
          else
            args.state.current_scene = 2
          end
        elsif args.state.selection == 1
          play_click_sound args
          args.state.current_scene = 4
        elsif args.state.selection == 2
          play_click_sound args
          args.state.current_scene = 5
        elsif args.state.selection == 3
          play_click_sound args
          $gtk.exit
        end
      end
    end
  end
  
  args.outputs.primitives << {
    x: args.state.trail_x,
    y: args.state.trail_y,
    w: args.state.menu_texts[args.state.selection][:trail_w],
    h: 5,
    r: 255,
    g: 0,
    b: 200,
    a: 255
  }.solid
end

def options_menu args
  aabb_first_button = AABB(args.inputs.mouse.x - 20, args.inputs.mouse.y.from_top, 1, 1, 480, 460.from_top, 100, 40)
  aabb_second_button = AABB(args.inputs.mouse.x - 20, args.inputs.mouse.y.from_top, 1, 1, 770, 460.from_top, 100, 40)
  aabb_third_button = AABB(args.inputs.mouse.x - 20, args.inputs.mouse.y.from_top, 1, 1, 511, 365.from_top, 60, 60)
  aabb_fourth_button = AABB(args.inputs.mouse.x - 20, args.inputs.mouse.y.from_top, 1, 1, 690, 365.from_top, 60, 60)
  aabb_fifth_button = AABB(args.inputs.mouse.x - 20, args.inputs.mouse.y.from_top, 1, 1, 528, 283.from_top, 100, 40)
  aabb_sixth_button = AABB(args.inputs.mouse.x - 20, args.inputs.mouse.y.from_top, 1, 1, 528, 213.from_top, 100, 40)
  aabb_seventh_button = AABB(args.inputs.mouse.x - 20, args.inputs.mouse.y.from_top, 1, 1, 324, 143.from_top, 580, 40)
  
  args.outputs.primitives << {
    x: 0,
    y: 760.from_top,
    w: 1280,
    h: 760,
    path: "sprites/background.jpg"
  }.sprite
  
  args.outputs.primitives << {
    x: 466,
    y: 32.from_top,
    text: "OPTIONS",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 48,
    r: 255,
    g: 0,
    b: 200,
    a: 255,
  }.label
  
  args.outputs.primitives << {
    x: 340,
    y: 640.from_top,
    w: 600,
    h: 400,
    r: 255,
    g: 0,
    b: 200,
    a: 255,
    line_width: 5
  }.border
  
  # BUTTON 1: Sound enable/disable
  args.outputs.primitives << {
    x: 360,
    y: 460,
    text: "SOUNDS:",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 10,
    r: 255,
    g: 0,
    b: 200,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: args.state.sound_enabled == 1 ? 530 : 525,
    y: args.state.sound_enabled == 1 ? 465 : 460,
    text: args.state.sound_enabled == 1 ? "ON" : "OFF",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 10,
    r: 255,
    g: 0,
    b: aabb_first_button ? 255 : 200,
    a: 255
  }.label
  
  #args.outputs.primitives << {
  #  x: 500,
  #  y: 300.from_top,
  #  w: 100,
  #  h: 40,
  #  r: 255,
  #  g: 0,
  #  b: 255,
  #  a: 255
  #}.border
  
  args.outputs.primitives << {
    x: 500,
    y: 420,
    w: 100,
    h: 40,
    r: 255,
    g: 0,
    b: aabb_first_button ? 255 : 200,
    a: 255,
  }.border
  
  # BUTTON 2: Music
  args.outputs.primitives << {
    x: 685,
    y: 460,
    text: "MUSIC:",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 10,
    r: 255,
    g: 0,
    b: 200,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: args.state.music_enabled == 1 ? 830 : 825,
    y: args.state.music_enabled == 1 ? 465 : 460,
    text: args.state.music_enabled == 1 ? "ON" : "OFF",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 10,
    r: 255,
    g: 0,
    b: aabb_second_button ? 255 : 200,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: 800,
    y: 420,
    w: 100,
    h: 40,
    r: 255,
    g: 0,
    b: aabb_second_button ? 255 : 200,
    a: 255,
    line_width: 5
  }.border
  
  # Audio Volume
  args.outputs.primitives << {
    x: 585,
    y: 400,
    text: "VOLUME",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 10,
    r: 255,
    g: 0,
    b: 200,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: args.state.volume < 100 ? 618 : 610,
    y: 340,
    text: args.state.volume,
    font: "fonts/ubuntu-title.ttf",
    size_enum: 10,
    r: 255,
    g: 0,
    b: 200,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: 590,
    y: 300,
    w: 100,
    h: 40,
    r: 255,
    g: 0,
    b: 200,
    a: 255,
    line_width: 5
  }.border
  
  # - button
  args.outputs.primitives << {
    x: 530,
    y: 300,
    w: 40,
    h: 40,
    r: 255,
    g: 0,
    b: aabb_third_button ? 255 : 200,
    a: 255,
    line_width: 5
  }.border
  
  args.outputs.primitives << {
    x: 540,
    y: 350,
    text: "-",
    size_enum: 16,
    font: "fonts/ubuntu-title.ttf",
    r: 255,
    g: 0,
    b: aabb_third_button ? 255 : 200,
    a: 255,
    line_width: 5
  }.label
  
  # + button
  args.outputs.primitives << {
    x: 710,
    y: 300,
    w: 40,
    h: 40,
    r: 255,
    g: 0,
    b: aabb_fourth_button ? 255 : 200,
    a: 255,
    line_width: 5
  }.border
  
  args.outputs.primitives << {
    x: 716,
    y: 336,
    text: "+",
    size_enum: 10,
    font: "fonts/ubuntu-title.ttf",
    r: 255,
    g: 0,
    b: aabb_fourth_button ? 255 : 200,
    a: 255,
    line_width: 5
  }.label
  
  # Painting mode button
  args.outputs.primitives << {
    x: 360,
    y: 260,
    text: "LUCK MODE:",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 10,
    r: 255,
    g: 0,
    b: 200,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: args.state.luck_mode == 1 ? 580 : 575,
    y: args.state.luck_mode == 1 ? 265 : 260,
    text: args.state.luck_mode == 1 ? "ON" : "OFF",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 10,
    r: 255,
    g: 0,
    b: aabb_fifth_button ? 255 : 200,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: 550,
    y: 220,
    w: 100,
    h: 40,
    r: 255,
    g: 0,
    b: aabb_fifth_button ? 255 : 200,
    a: 255,
  }.border
  
  # Fullscreen button
  args.outputs.primitives << {
    x: 360,
    y: 200,
    text: "FULLSCREEN:",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 10,
    r: 255,
    g: 0,
    b: 200,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: args.state.fullscreen == 1 ? 580 : 575,
    y: args.state.fullscreen == 1 ? 205 : 200,
    text: args.state.fullscreen == 1 ? "ON" : "OFF",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 10,
    r: 255,
    g: 0,
    b: aabb_sixth_button ? 255 : 200,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: 550,
    y: 160,
    w: 100,
    h: 40,
    r: 255,
    g: 0,
    b: aabb_sixth_button ? 255 : 200,
    a: 255,
  }.border
  
  # Clear data button :(
  args.outputs.primitives << {
    x: 540,
    y: 135,
    text: "CLEAR DATA :(",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 10,
    r: 255,
    g: 0,
    b: aabb_seventh_button ? 255 : 200,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: 350,
    y: 95,
    w: 580,
    h: 40,
    r: 255,
    g: 0,
    b: aabb_seventh_button ? 255 : 200,
    a: 255,
  }.border
  
  args.outputs.primitives << {
    x: 16,
    y: 660.from_top,
    text: "BACK",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 10,
    r: 255,
    g: 0,
    b: AABB(args.inputs.mouse.x - 20, (args.inputs.mouse.y + 595).from_top, 1, 1, 16, 660.from_top, 32, 100) ? 255 : 180,
    a: 255
  }.label
  
  #$gtk.log "X: #{args.inputs.mouse.x}, Y: #{args.inputs.mouse.y}"
  
  if args.inputs.mouse.click && args.inputs.mouse.button_left
    if AABB(args.inputs.mouse.x - 20, (args.inputs.mouse.y + 595).from_top, 1, 1, 16, 660.from_top, 32, 100)
      play_click_sound args
      args.state.current_scene = 0
      args.state.clear_data_timer = 0
      args.state.data_cleared = 0
      $gtk.serialize_state("game_state.txt", args.state)
    elsif aabb_first_button
      play_click_sound args
      args.state.sound_enabled = args.state.sound_enabled == 1 ? 0 : 1
    elsif aabb_second_button
      play_click_sound args
      args.state.music_enabled = args.state.music_enabled == 1 ? 0 : 1
    elsif aabb_third_button
      play_click_sound args
      if !(args.state.volume - 1 < 0)
        args.state.volume -= 1
      end
    elsif aabb_fourth_button
      play_click_sound args
      if !(args.state.volume + 1 > 100)
        args.state.volume += 1
      end
    elsif aabb_fifth_button
      play_click_sound args
      args.state.luck_mode = args.state.luck_mode == 1 ? 0 : 1
    elsif aabb_sixth_button
      play_click_sound args
      args.state.fullscreen = args.state.fullscreen == 1 ? 0 : 1
    elsif aabb_seventh_button
      play_click_sound args
      args.state.luck_mode = 0
      args.state.current_level = 0
      args.state.played_game_previously = 0
      args.state.clear_data_timer = 0
      args.state.data_cleared = 1
    end
  end
  
  if args.state.data_cleared == 1
    if args.state.clear_data_timer + 1 < 120
      args.state.clear_data_timer += 1
        
      args.outputs.primitives << {
        x: 0,
        y: 0.from_top,
        w: 1280,
        h: 40,
        r: 0,
        g: 0,
        b: 0,
        a: 255
      }.solid
        
      args.outputs.primitives << {
        x: 0,
        y: 0.from_top,
        text: "GAME DATA CLEARED SUCCESSFULLY! :(",
        font: "fonts/ubuntu-title.ttf",
        size_enum: 8,
        r: 255,
        g: 0,
        b: 255,
        a: 255
      }.label
    end
  end
end

def credits_menu args
  args.state.hover_on_link = AABB(args.inputs.mouse.x - 20, (args.inputs.mouse.y + 40).from_top, 1, 1, 376, 382.from_top, 500, 48)
  
  args.outputs.primitives << {
    x: 0,
    y: 760.from_top,
    w: 1280,
    h: 760,
    path: "sprites/background.jpg"
  }.sprite
  
  args.outputs.primitives << {
    x: 416,
    y: 32.from_top,
    text: "LUCKPAINT",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 48,
    r: 255,
    g: 0,
    b: 200,
    a: 255,
  }.label
  
  args.outputs.primitives << {
    x: 632,
    y: 142.from_top,
    text: "BY RABIA ALHAFFAR",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 6,
    r: 255,
    g: 0,
    b: 200,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: 336,
    y: 282.from_top,
    text: "GAME MADE FOR JUICY JAM #1",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 16,
    r: 255,
    g: 0,
    b: 200,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: 376,
    y: 382.from_top,
    text: "https://itch.io/jam/juicy-jam-1",
    size_enum: 8,
    r: 255,
    g: 0,
    b: args.state.hover_on_link ? 255 : 180,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: 400,
    y: 540.from_top,
    text: "THANKS FOR PLAYING! ;)",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 16,
    r: 255,
    g: 0,
    b: 200,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: 16,
    y: 660.from_top,
    text: "BACK",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 10,
    r: 255,
    g: 0,
    b: 200,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: 16,
    y: 660.from_top,
    text: "BACK",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 10,
    r: 255,
    g: 0,
    b: AABB(args.inputs.mouse.x - 20, (args.inputs.mouse.y + 595).from_top, 1, 1, 16, 660.from_top, 32, 100) ? 255 : 180,
    a: 255
  }.label
  
  if args.inputs.mouse.click && args.inputs.mouse.button_left
    if AABB(args.inputs.mouse.x - 20, (args.inputs.mouse.y + 595).from_top, 1, 1, 16, 660.from_top, 32, 100)
      play_click_sound args
      args.state.current_scene = 0
    elsif args.state.hover_on_link
      play_click_sound args
      $gtk.openurl "https://itch.io/jam/juicy-jam-1"
    end
  end
end

def select_mode_menu args
  aabb_first_mode = AABB(args.inputs.mouse.x - 20, args.inputs.mouse.y.from_top, 1, 1, 320, 522.from_top, 610, 160)
  aabb_second_mode = AABB(args.inputs.mouse.x - 20, args.inputs.mouse.y.from_top, 1, 1, 320, 280.from_top, 610, 160)

  args.outputs.primitives << {
    x: 0,
    y: 760.from_top,
    w: 1280,
    h: 760,
    path: "sprites/background.jpg"
  }.sprite
  
  args.outputs.primitives << {
    x: 336,
    y: 32.from_top,
    text: "SELECT GAME MODE",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 32,
    r: 255,
    g: 0,
    b: 200,
    a: 255,
  }.label
  
  # Selection 1
  args.outputs.primitives << {
    x: 520,
    y: 200.from_top,
    text: "LUCK MODE",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 22,
    r: 255,
    g: 0,
    b: aabb_first_mode ? 200 : 255,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: 350,
    y: 350.from_top,
    w: 600,
    h: 150,
    r: 255,
    g: 0,
    b: aabb_first_mode ? 200 : 255,
    a: 255
  }.border
  
  args.outputs.primitives << {
    x: 430,
    y: 300.from_top,
    text: "MADE FOR JUICY JAM #1 THEME",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 8,
    r: 255,
    g: 0,
    b: aabb_first_mode ? 200 : 255,
    a: 255
  }.label
  
  # Selection 2
  args.outputs.primitives << {
    x: 480,
    y: 450.from_top,
    text: "NORMAL MODE",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 22,
    r: 255,
    g: 0,
    b: aabb_second_mode ? 200 : 255,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: 350,
    y: 600.from_top,
    w: 600,
    h: 150,
    r: 255,
    g: 0,
    b: aabb_second_mode ? 200 : 255,
    a: 255
  }.border
  
  args.outputs.primitives << {
    x: 400,
    y: 550.from_top,
    text: "DEFAULT MODE MADE FOR THE GAME",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 8,
    r: 255,
    g: 0,
    b: aabb_second_mode ? 200 : 255,
    a: 255
  }.label
  
  args.outputs.primitives << {
    x: 16,
    y: 660.from_top,
    text: "BACK",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 10,
    r: 255,
    g: 0,
    b: AABB(args.inputs.mouse.x - 20, (args.inputs.mouse.y + 595).from_top, 1, 1, 16, 660.from_top, 32, 100) ? 255 : 180,
    a: 255
  }.label
  
  #$gtk.log "X: #{args.inputs.mouse.x}, Y: #{args.inputs.mouse.y}"
  # x: 384, y: 522
  # x: 350, y: 280
  
  if args.inputs.mouse.click && args.inputs.mouse.button_left
    if AABB(args.inputs.mouse.x - 20, (args.inputs.mouse.y + 595).from_top, 1, 1, 16, 660.from_top, 32, 100)
      play_click_sound args
      args.state.current_scene = 0
    elsif aabb_first_mode
      play_click_sound args
      args.state.luck_mode = 1
      args.state.current_scene = 2
    elsif aabb_second_mode
      play_click_sound args
      args.state.luck_mode = 0
      args.state.current_scene = 2
    end
  end
end

def pause_menu args
  aabb_first_text = AABB(args.inputs.mouse.x, args.inputs.mouse.y.from_top, 1, 1, 520, 330, 200, 100)
  aabb_second_text = AABB(args.inputs.mouse.x, args.inputs.mouse.y.from_top, 1, 1, 500, 440, 200, 100)
  aabb_third_text = AABB(args.inputs.mouse.x, args.inputs.mouse.y.from_top, 1, 1, 586, 550, 200, 100)

  args.outputs.primitives << {
    x: 0,
    y: 760.from_top,
    w: 1280,
    h: 760,
    path: "sprites/background.jpg"
  }.sprite
  
  args.outputs.primitives << {
    x: 366,
    y: 32.from_top,
    text: "GAME PAUSED! :(",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 32,
    r: 255,
    g: 0,
    b: 200,
    a: 255,
  }.label
  
  args.outputs.primitives << {
    x: 520,
    y: 330.from_top,
    text: "CONTINUE",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 22,
    r: 255,
    g: 0,
    b: aabb_first_text ? 255 : 200,
    a: 255,
  }.label
  
  args.outputs.primitives << {
    x: 500,
    y: 440.from_top,
    text: "MAIN MENU",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 22,
    r: 255,
    g: 0,
    b: aabb_second_text ? 255 : 200,
    a: 255,
  }.label
  
  args.outputs.primitives << {
    x: 586,
    y: 550.from_top,
    text: "EXIT",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 22,
    r: 255,
    g: 0,
    b: aabb_third_text ? 255 : 200,
    a: 255,
  }.label
  
  if args.inputs.mouse.click && args.inputs.mouse.button_left
    if aabb_first_text
      play_click_sound args
      args.state.current_scene = 2
    elsif aabb_second_text
      play_click_sound args
      args.state.current_scene = 0
    elsif aabb_third_text
      play_click_sound args
      $gtk.exit
    end
  end
end

def play_game args
  args.state.played_game_previously = 1
  render_game args
  game_input args
  finished_level args
end

def render_game args
  aabb_pause_button = AABB(args.inputs.mouse.x, args.inputs.mouse.y, 1, 1, 1220, 64.from_top, 32, 64)
  
  args.outputs.primitives << {
    x: 0,
    y: 760.from_top,
    w: 1280,
    h: 760,
    path: "sprites/background.jpg"
  }.sprite
  
  args.outputs.primitives << {
    x: 8,
    y: 8.from_top,
    text: "LEVEL #{args.state.current_level + 1}",
    size_enum: 16,
    font: "fonts/ubuntu-title.ttf",
    r: 255,
    g: 255,
    b: 255,
    a: 255
  }.label
  
#DEBUG
# This to draw level finished! (To see if something is going wrong)
=begin
  args.state.levels[args.state.current_level][:content].length.times do |i|
    args.state.levels[args.state.current_level][:content][i].length.times do |j|
      args.outputs.primitives << {
        x: 416 + (j * 32) + 96,
        y: (264 + (i * 32)).from_top,
        w: 32,
        h: 32,
        r: args.state.levels[args.state.current_level][:palette][args.state.levels[args.state.current_level][:content][i][j]].r,
        g: args.state.levels[args.state.current_level][:palette][args.state.levels[args.state.current_level][:content][i][j]].g,
        b: args.state.levels[args.state.current_level][:palette][args.state.levels[args.state.current_level][:content][i][j]].b,
        a: args.state.levels[args.state.current_level][:palette][args.state.levels[args.state.current_level][:content][i][j]].a,
      }.solid
    end
  end
=end

  args.state.current_grid.length.times.map do |i|
    args.state.current_grid[i].length.times.map do |j|
      if args.state.current_grid[i][j] == 0
        if args.state.levels[args.state.current_level][:content][i][j] > 0
          args.outputs.primitives << {
            x: 416 + (j * 32) + 96,
            y: (264 + (i * 32)).from_top,
            w: 32,
            h: 32,
            r: 255,
            g: 255,
            b: 255,
            a: 255
          }.border
      
          args.outputs.primitives << {
            x: 416 + (j * 32) + 96 + 4,
            y: (264 + (i * 32) - 32).from_top,
            text: args.state.levels[args.state.current_level][:content][i][j],
            size_enum: 8,
            font: "fonts/ubuntu-title.ttf",
            r: 255,
            g: 255,
            b: 255,
            a: 255
          }.label
        end
      else
        args.outputs.primitives << {
          x: 416 + (j * 32) + 96,
          y: (264 + (i * 32)).from_top,
          w: 32,
          h: 32,
          r: args.state.levels[args.state.current_level][:palette][args.state.current_grid[i][j]].r,
          g: args.state.levels[args.state.current_level][:palette][args.state.current_grid[i][j]].g,
          b: args.state.levels[args.state.current_level][:palette][args.state.current_grid[i][j]].b,
          a: args.state.painting_alpha,
        }.solid
      end
    end
  end
  
  args.state.levels[args.state.current_level][:palette].length.times.map do |i|
    args.outputs.primitives << {
      x: -64 + (i * 64),
      y: 0,
      w: 64,
      h: 64,
      r: args.state.levels[args.state.current_level][:palette][i].r,
      g: args.state.levels[args.state.current_level][:palette][i].g,
      b: args.state.levels[args.state.current_level][:palette][i].b,
      a: args.state.painting_alpha,
    }.solid
    
    args.outputs.primitives << {
      x: -64 + (i * 64) + 16,
      y: 56,
      text: i,
      font: "fonts/ubuntu-title.ttf",
      size_enum: 16,
      r: 0,
      g: 0,
      b: 0,
      a: args.state.painting_alpha
    }.label
  end
  
  if args.state.selected_color > 0
    args.outputs.primitives << {
      x: -64 + args.state.selected_color * 64,
      y: 0,
      w: 64,
      h: 64,
      r: 0,
      g: 0,
      b: 0,
      a: args.state.painting_alpha
    }.border
  end
  
  args.outputs.primitives << {
    x: 1220,
    y: 20.from_top,
    text: "||",
    font: "fonts/ubuntu-title.ttf",
    size_enum: 16,
    r: aabb_pause_button ? 0 : 255,
    g: aabb_pause_button ? 200 : 255,
    b: 255,
    a: 255
  }.label
end

def game_input args
  aabb_pause_button = AABB(args.inputs.mouse.x, args.inputs.mouse.y, 1, 1, 1220, 64.from_top, 32, 64)
  
  args.state.keys.length.times.map do |i|
    if args.state.keys[i]
      if i < args.state.levels[args.state.current_level][:palette].length
        play_click_sound args
        args.state.selected_color = i
      end
    end
  end
  
  if args.inputs.mouse.button_left & args.inputs.mouse.click
    args.state.levels[args.state.current_level][:palette].length.times.map do |i|
      if AABB(args.inputs.mouse.x, args.inputs.mouse.y.from_top, 1, 1, (-64 + i * 64), 64.from_top, 64, 64)
        play_click_sound args
        args.state.selected_color = i
      end
    end
  end
  
  if args.inputs.mouse.click && args.inputs.mouse.button_left
    if aabb_pause_button
      play_click_sound args
      args.state.current_scene = 3
    end
  end
  
  if args.inputs.mouse.button_left
    args.state.current_grid.length.times.map do |i|
      args.state.current_grid[i].length.times.map do |j|
        if AABB(args.inputs.mouse.x, args.inputs.mouse.y, 1, 1, 416 + (j * 32) + 96, (264 + (i * 32)).from_top, 32, 32)
          if args.state.levels[args.state.current_level][:content][i][j] == args.state.selected_color
            args.state.paiting = true
            args.state.current_grid[i][j] = args.state.selected_color
            
            if args.state.sound_enabled == 1
              args.audio[:pop] ||= {
                input: "audio/244657__greenvwbeetle__pop-5.wav",
                x: 0.0,
                y: 0.0,
                z: 0.0,
                gain: args.state.volume / 100,
                pitch: 1.0,
                paused: false,
                looping: false,
              }
            end
            #play_click_sound args
          else
            args.state.paiting = false
          end
        else
          args.state.painting = false
        end
      end
    end
  end
end

# If level finished, Save game automatically and then clear current_grid result to move on next level
def finished_level args
  matches = 0
  
  args.state.current_grid.length.times.map do |i|
    if arr_match(args.state.current_grid[i], args.state.levels[args.state.current_level][:content][i])
      matches += 1
    end
  end
  
  if matches == args.state.current_grid.length
    if !args.state.levels[args.state.current_level][:finished]
      if args.state.current_level + 1 < args.state.levels.length
        args.state.painting_alpha -= 2
        args.state.paint_finish_timer += 1
        
        if args.state.sound_enabled == 1
          args.audio[:win] ||= {
            input: "audio/434612__jens-enk__completed.ogg",
            x: 0.0,
            y: 0.0,
            z: 0.0,
            gain: args.state.volume / 100,
            pitch: 1.0,
            paused: false,
            looping: false,
          }
        end
        
        if args.state.paint_finish_timer + 1 == 180
          args.state.levels[args.state.current_level][:finished] = true
          args.state.current_grid = [
            [ 0, 0, 0, 0, 0, 0, 0, 0 ],
            [ 0, 0, 0, 0, 0, 0, 0, 0 ],
            [ 0, 0, 0, 0, 0, 0, 0, 0 ],
            [ 0, 0, 0, 0, 0, 0, 0, 0 ],
            [ 0, 0, 0, 0, 0, 0, 0, 0 ],
            [ 0, 0, 0, 0, 0, 0, 0, 0 ],
            [ 0, 0, 0, 0, 0, 0, 0, 0 ],
            [ 0, 0, 0, 0, 0, 0, 0, 0 ],
          ]
          args.state.current_level += 1
          args.state.selected_color = 0
          args.state.painting_alpha = 255
          args.state.paint_finish_timer = 0
          $gtk.serialize_state("game_state.txt", args.state)
        end
      end
    end
  end
end
