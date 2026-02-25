package input

import "base:runtime"
import "core:strings"

import "vendor:glfw"

Action_State :: enum {
	Not_Pressed = 0,
	Just_Released,
	Just_Pressed,
	Pressed,
}

Mouse_Mode :: enum {
	Visible = 0,
	Captured,
}

Mouse_Input :: struct {
	relative: [2]f32,
	position: [2]f32,
	buttons:  [glfw.MOUSE_BUTTON_LAST + 1]Action_State,
	scroll:   [2]f32,
}

Key :: enum i32 {
	Space         = glfw.KEY_SPACE,
	Apostrophe    = glfw.KEY_APOSTROPHE,
	Comma         = glfw.KEY_COMMA,
	Minus         = glfw.KEY_MINUS,
	Period        = glfw.KEY_PERIOD,
	Slash         = glfw.KEY_SLASH,
	Semicolon     = glfw.KEY_SEMICOLON,
	Equal         = glfw.KEY_EQUAL,
	Left_Bracket  = glfw.KEY_LEFT_BRACKET,
	Backslash     = glfw.KEY_BACKSLASH,
	Right_Bracket = glfw.KEY_RIGHT_BRACKET,
	Grave_Accent  = glfw.KEY_GRAVE_ACCENT,
	World_1       = glfw.KEY_WORLD_1,
	World_2       = glfw.KEY_WORLD_2,
	Key_0         = glfw.KEY_0,
	Key_1         = glfw.KEY_1,
	Key_2         = glfw.KEY_2,
	Key_3         = glfw.KEY_3,
	Key_4         = glfw.KEY_4,
	Key_5         = glfw.KEY_5,
	Key_6         = glfw.KEY_6,
	Key_7         = glfw.KEY_7,
	Key_8         = glfw.KEY_8,
	Key_9         = glfw.KEY_9,
	A             = glfw.KEY_A,
	B             = glfw.KEY_B,
	C             = glfw.KEY_C,
	D             = glfw.KEY_D,
	E             = glfw.KEY_E,
	F             = glfw.KEY_F,
	G             = glfw.KEY_G,
	H             = glfw.KEY_H,
	I             = glfw.KEY_I,
	J             = glfw.KEY_J,
	K             = glfw.KEY_K,
	L             = glfw.KEY_L,
	M             = glfw.KEY_M,
	N             = glfw.KEY_N,
	O             = glfw.KEY_O,
	P             = glfw.KEY_P,
	Q             = glfw.KEY_Q,
	R             = glfw.KEY_R,
	S             = glfw.KEY_S,
	T             = glfw.KEY_T,
	U             = glfw.KEY_U,
	V             = glfw.KEY_V,
	W             = glfw.KEY_W,
	X             = glfw.KEY_X,
	Y             = glfw.KEY_Y,
	Z             = glfw.KEY_Z,
	Escape        = glfw.KEY_ESCAPE,
	Enter         = glfw.KEY_ENTER,
	Tab           = glfw.KEY_TAB,
	Backspace     = glfw.KEY_BACKSPACE,
	Insert        = glfw.KEY_INSERT,
	Delete        = glfw.KEY_DELETE,
	Right         = glfw.KEY_RIGHT,
	Left          = glfw.KEY_LEFT,
	Down          = glfw.KEY_DOWN,
	Up            = glfw.KEY_UP,
	Page_Up       = glfw.KEY_PAGE_UP,
	Page_Down     = glfw.KEY_PAGE_DOWN,
	Home          = glfw.KEY_HOME,
	End           = glfw.KEY_END,
	Caps_Lock     = glfw.KEY_CAPS_LOCK,
	Scroll_Lock   = glfw.KEY_SCROLL_LOCK,
	Num_Lock      = glfw.KEY_NUM_LOCK,
	Print_Screen  = glfw.KEY_PRINT_SCREEN,
	Pause         = glfw.KEY_PAUSE,
	F1            = glfw.KEY_F1,
	F2            = glfw.KEY_F2,
	F3            = glfw.KEY_F3,
	F4            = glfw.KEY_F4,
	F5            = glfw.KEY_F5,
	F6            = glfw.KEY_F6,
	F7            = glfw.KEY_F7,
	F8            = glfw.KEY_F8,
	F9            = glfw.KEY_F9,
	F10           = glfw.KEY_F10,
	F11           = glfw.KEY_F11,
	F12           = glfw.KEY_F12,
	F13           = glfw.KEY_F13,
	F14           = glfw.KEY_F14,
	F15           = glfw.KEY_F15,
	F16           = glfw.KEY_F16,
	F17           = glfw.KEY_F17,
	F18           = glfw.KEY_F18,
	F19           = glfw.KEY_F19,
	F20           = glfw.KEY_F20,
	F21           = glfw.KEY_F21,
	F22           = glfw.KEY_F22,
	F23           = glfw.KEY_F23,
	F24           = glfw.KEY_F24,
	F25           = glfw.KEY_F25,
	Kp_0          = glfw.KEY_KP_0,
	Kp_1          = glfw.KEY_KP_1,
	Kp_2          = glfw.KEY_KP_2,
	Kp_3          = glfw.KEY_KP_3,
	Kp_4          = glfw.KEY_KP_4,
	Kp_5          = glfw.KEY_KP_5,
	Kp_6          = glfw.KEY_KP_6,
	Kp_7          = glfw.KEY_KP_7,
	Kp_8          = glfw.KEY_KP_8,
	Kp_9          = glfw.KEY_KP_9,
	Kp_Decimal    = glfw.KEY_KP_DECIMAL,
	Kp_Divide     = glfw.KEY_KP_DIVIDE,
	Kp_Multiply   = glfw.KEY_KP_MULTIPLY,
	Kp_Subtract   = glfw.KEY_KP_SUBTRACT,
	Kp_Add        = glfw.KEY_KP_ADD,
	Kp_Enter      = glfw.KEY_KP_ENTER,
	Kp_Equal      = glfw.KEY_KP_EQUAL,
	Left_Shift    = glfw.KEY_LEFT_SHIFT,
	Left_Control  = glfw.KEY_LEFT_CONTROL,
	Left_Alt      = glfw.KEY_LEFT_ALT,
	Left_Super    = glfw.KEY_LEFT_SUPER,
	Right_Shift   = glfw.KEY_RIGHT_SHIFT,
	Right_Control = glfw.KEY_RIGHT_CONTROL,
	Right_Alt     = glfw.KEY_RIGHT_ALT,
	Right_Super   = glfw.KEY_RIGHT_SUPER,
	Menu          = glfw.KEY_MENU,
	Last          = glfw.KEY_LAST,
}

keys:        map[Key]Action_State
mouse_mode:  Mouse_Mode
mouse_input: Mouse_Input

@(private)
window_handle: glfw.WindowHandle

@(private)
scroll_callback :: proc "c" (window_handle: glfw.WindowHandle, xoffset, yoffset: f64) {
	mouse_input.scroll += {f32(xoffset), f32(yoffset)}
}

@(private)
key_callback :: proc "c" (window_handle: glfw.WindowHandle, key, scancode, action, mods: i32) {
	switch action {
	case glfw.PRESS:
		keys[Key(key)] = .Just_Pressed
	case glfw.RELEASE:
		keys[Key(key)] = .Just_Released
	}
}

@(private)
mouse_button_callback :: proc "c" (window_handle: glfw.WindowHandle, button, action, mods: i32) {
	action_state := Action_State.Pressed
	switch action {
	case glfw.PRESS:
		action_state = .Just_Pressed
	case glfw.RELEASE:
		action_state = .Just_Released
	}
	mouse_input.buttons[button] = action_state
}

mouse_moved := 0

// @(private)
// cursor_pos_callback :: proc "c" (window_handle: glfw.WindowHandle, x_pos, y_pos: f64) {
// 	if mouse_mode == .Captured {
// 		// win_x, win_y := glfw.GetWindowSize(window_handle)
// 		// glfw.SetCursorPos(window_handle, f64(win_x) / 2, f64(win_y) / 2)
// 		// mid_x, mid_y := glfw.GetCursorPos(window_handle)

// 		// new_x, new_y := glfw.GetCursorPos(window_handle)
// 		new_x, new_y := f32(x_pos), f32(y_pos)

// 		mouse_input.relative.x = f32(new_x) - mouse_input.position.x
// 		mouse_input.relative.y = f32(new_y) - mouse_input.position.y

// 		mouse_input.position.x = f32(new_x)
// 		mouse_input.position.y = f32(new_y)
// 	} else {
// 		mouse_input.position.x = auto_cast x_pos
// 		mouse_input.position.y = auto_cast y_pos
// 		mouse_input.relative += {f32(x_pos), f32(y_pos)} - mouse_input.position
// 	}

// 	mouse_moved = 0
// }

char_callback :: proc "c" (window_handle: glfw.WindowHandle, codepoint: rune) {
	context = runtime.default_context()
	strings.write_rune(&text_input, codepoint)
}

init :: proc(window: glfw.WindowHandle) {
	window_handle = window
	glfw.SetMouseButtonCallback(window_handle, mouse_button_callback)
	glfw.SetKeyCallback(window_handle, key_callback)
	// glfw.SetCursorPosCallback(window_handle, cursor_pos_callback)
	glfw.SetScrollCallback(window_handle, scroll_callback)
	glfw.SetCharCallback(window_handle, char_callback)
}

poll :: proc() {
	for key, key_val in keys {
		if key_val == .Just_Pressed do keys[key] = .Pressed
		if key_val == .Just_Released do keys[key] = .Not_Pressed
	}
	// mouse_moved += 1
	// if mouse_moved > 1 do mouse_input.relative = {0, 0}
	mouse_input.scroll = 0

	for &mb in mouse_input.buttons {
		if mb == .Just_Pressed do mb = .Pressed
		if mb == .Just_Released do mb = .Not_Pressed
	}

	new_x, new_y := glfw.GetCursorPos(window_handle)

	mouse_input.relative.x = f32(new_x) - mouse_input.position.x
	mouse_input.relative.y = f32(new_y) - mouse_input.position.y

	mouse_input.position.x = f32(new_x)
	mouse_input.position.y = f32(new_y)

	strings.builder_reset(&text_input)
}

set_mouse_mode :: proc(mode: Mouse_Mode) {
	mouse_mode = mode
	if mode == .Captured {
		// win_x, win_y := glfw.GetWindowSize(window_handle)
		// glfw.SetCursorPos(window_handle, f64(win_x) / 2, f64(win_y) / 2)
		new_x, new_y := glfw.GetCursorPos(window_handle)

		mouse_input.relative.x = f32(new_x) - mouse_input.position.x
		mouse_input.relative.y = f32(new_y) - mouse_input.position.y

		mouse_input.position.x = f32(new_x)
		mouse_input.position.y = f32(new_y)
	}
	mouse_input.relative = {0, 0}
	new_mode: i32 = glfw.CURSOR_NORMAL
	if mode != .Visible do new_mode = glfw.CURSOR_DISABLED
	glfw.SetInputMode(window_handle, glfw.CURSOR, new_mode)
}

get_mouse_button :: proc(button_index: i32) -> bool {
	return(
		mouse_input.buttons[button_index] == .Pressed ||
		mouse_input.buttons[button_index] == .Just_Pressed \
	)
}

get_mouse_button_down :: proc(button_index: i32) -> bool {
	return mouse_input.buttons[button_index] == .Just_Pressed
}

get_mouse_button_up :: proc(button_index: i32) -> bool {
	return mouse_input.buttons[button_index] == .Just_Released
}

get_mouse_position :: proc() -> [2]f32 {
	return mouse_input.position
}

get_mouse_relative :: proc() -> [2]f32 {
	return mouse_input.relative
}

get_key :: proc(key: Key) -> bool {
	action := keys[key]
	return action == .Pressed || action == .Just_Pressed
}

get_key_down :: proc(key: Key) -> bool {
	action := keys[key]
	return action == .Just_Pressed
}

get_key_up :: proc(key: Key) -> bool {
	action := keys[key]
	return action == .Just_Released
}

get_key_raw :: proc(key: Key) -> Action_State {
	return keys[key]
}

get_mouse_button_raw :: proc(button_index: i32) -> Action_State {
	return mouse_input.buttons[button_index]
}

get_scroll :: proc() -> [2]f32 {
	return mouse_input.scroll
}

text_input: strings.Builder

get_text_input :: proc() -> string {
	return strings.to_string(text_input)
}
