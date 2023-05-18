/// The Symbolic name or representation of the keyboard key.
pub const VirtualKey = enum(i32) {
    Unknown, // Unknown key
    A, // The A key
    B, // The B key
    C, // The C key
    D, // The D key
    E, // The E key
    F, // The F key
    G, // The G key
    H, // The H key
    I, // The I key
    J, // The J key
    K, // The K key
    L, // The L key
    M, // The M key
    N, // The N key
    O, // The O key
    P, // The P key
    Q, // The Q key
    R, // The R key
    S, // The S key
    T, // The T key
    U, // The U key
    V, // The V key
    W, // The W key
    X, // The X key
    Y, // The Y key
    Z, // The Z key
    Num0, // The 0 key
    Num1, // The 1 key
    Num2, // The 2 key
    Num3, // The 3 key
    Num4, // The 4 key
    Num5, // The 5 key
    Num6, // The 6 key
    Num7, // The 7 key
    Num8, // The 8 key
    Num9, // The 9 key
    Escape, // The Escape key
    Control, // The left Control key
    Shift, // The left Shift key
    Alt, // The left Alt key
    System, // The left OS specific key: window (Windows and Linux), apple (MacOS X), ...
    LBracket, // The [ and { key
    RBracket, // The ] and } key
    Semicolon, // The ; and : key
    Comma, // The , key
    Period, // The . key
    Quote, // The ' and " key
    Slash, // The / and ? key
    Backslash, // The \ and | key
    Grave, // The ` and ~ key
    Equals, // The = key
    Hyphen, // The - key (hyphen)
    Space, // The Space key
    Return, // The Enter/Return keys
    Backspace, // The Backspace key
    Tab, // The Tabulation key
    CapsLock, // The Caps Lock Key
    PageUp, // The Page up key
    PageDown, // The Page down key
    PrintScreen, // The Print Page key
    End, // The End key
    Home, // The Home key
    Insert, // The Insert key
    Delete, // The Delete key
    Pause, // The Pause Key
    Menu, // The Menu key
    Left, // Left arrow
    Right, // Right arrow
    Up, // Up arrow
    Down, // Down arrow
    Numpad0, // The numpad 0 key
    Numpad1, // The numpad 1 key
    Numpad2, // The numpad 2 key
    Numpad3, // The numpad 3 key
    Numpad4, // The numpad 4 key
    Numpad5, // The numpad 5 key
    Numpad6, // The numpad 6 key
    Numpad7, // The numpad 7 key
    Numpad8, // The numpad 8 key
    Numpad9, // The numpad 9 key
    Add, // The numpad + key
    Substract, // The numpad - key
    Multiply, // The Numpad * key
    Divide, // The Numpad / key
    NumLock, // The Num Lock key
    ScrollLock, // The ScrLk key
    F1, // The F1 key
    F2, // The F2 key
    F3, // The F3 key
    F4, // The F4 key
    F5, // The F5 key
    F6, // The F6 key
    F7, // The F7 key
    F8, // The F8 key
    F9, // The F9 key
    F10, // The F10 key
    F11, // The F11 key
    F12, // The F12 key
    VolumeUp, // The Volume Up Key
    VolumeDown, // The Volume Down Key
    VolumeMute, // The Volume Mute key
    NextTrack, // The >>| key
    PrevTrack, // The |<< key
    PlayPause, // The play/pause key
};

pub const ScanCode = enum(i32) {
    Unknown = -1, // Unknown key
    A = 0, // The A key
    B = 1, // The B key
    C, // The C key
    D, // The D key
    E, // The E key
    F, // The F key
    G, // The G key
    H, // The H key
    I, // The I key
    J, // The J key
    K, // The K key
    L, // The L key
    M, // The M key
    N, // The N key
    O, // The O key
    P, // The P key
    Q, // The Q key
    R, // The R key
    S, // The S key
    T, // The T key
    U, // The U key
    V, // The V key
    W, // The W key
    X, // The X key
    Y, // The Y key
    Z, // The Z key
    Num0, // The 0 key
    Num1, // The 1 key
    Num2, // The 2 key
    Num3, // The 3 key
    Num4, // The 4 key
    Num5, // The 5 key
    Num6, // The 6 key
    Num7, // The 7 key
    Num8, // The 8 key
    Num9, // The 9 key
    Escape, // The Escape key
    LControl, // The left Control key
    LShift, // The left Shift key
    LAlt, // The left Alt key
    LSystem, // The left OS specific key: window (Windows and Linux), apple (MacOS X), ...
    RControl, // The right Control key
    RShift, // The right Shift key
    RAlt, // The right Alt key
    RSystem, // The right OS specific key: window (Windows and Linux), apple (MacOS X), ...
    LBracket, // The [ and { key
    RBracket, // The ] and } key
    Semicolon, // The ; and : key
    Comma, // The , key
    Period, // The . key
    Quote, // The ' and " key
    Slash, // The / and ? key
    Backslash, // The \ and | key
    Grave, // The ` and ~ key
    Equals, // The = key
    Hyphen, // The - key (hyphen)
    Space, // The Space key
    Return, // The Enter/Return keys
    Backspace, // The Backspace key
    Tab, // The Tabulation key
    CapsLock, // The Caps Lock Key
    PageUp, // The Page up key
    PageDown, // The Page down key
    PrintScreen, // The Print Page key
    End, // The End key
    Home, // The Home key
    Insert, // The Insert key
    Delete, // The Delete key
    Pause, // The Pause Key
    Menu, // The Menu key
    Left, // Left arrow
    Right, // Right arrow
    Up, // Up arrow
    Down, // Down arrow
    Numpad0, // The numpad 0 key
    Numpad1, // The numpad 1 key
    Numpad2, // The numpad 2 key
    Numpad3, // The numpad 3 key
    Numpad4, // The numpad 4 key
    Numpad5, // The numpad 5 key
    Numpad6, // The numpad 6 key
    Numpad7, // The numpad 7 key
    Numpad8, // The numpad 8 key
    Numpad9, // The numpad 9 key
    NumpadReturn, // The numpad Enter/Return key
    NumpadAdd, // The numpad + key
    NumpadSubstract, // The numpad - key
    NumpadMultiply, // The Numpad * key
    NumpadDivide, // The Numpad / key
    NumpadEquals, // The Numpad = key
    NumpadDecimal, // The numpad period(.) key
    NumLock, // The Num Lock key
    ScrollLock, // The ScrLk key
    F1, // The F1 key
    F2, // The F2 key
    F3, // The F3 key
    F4, // The F4 key
    F5, // The F5 key
    F6, // The F6 key
    F7, // The F7 key
    F8, // The F8 key
    F9, // The F9 key
    F10, // The F10 key
    F11, // The F11 key
    F12, // The F12 key
    Key102nd, // Unlabeled usually backslash on non us keyboards
    VolumeUp, // The Volume Up Key
    VolumeDown, // The Volume Down Key
    VolumeMute, // The Volume Mute key
    NextTrack, // The >>| key
    PrevTrack, // The |<< key
    PlayPause, // The play/pause key
    // END
    NUMBER_OF_KEYS,
};
// pub const NUMBER_OF_KEYS: usize = 112;

pub const KeyModifiers = struct {
    shift: bool,
    ctrl: bool,
    alt: bool,
    system_key: bool,
    caps_lock: bool,
    num_lock: bool,
};

pub const KeyAction = enum(u8) {
    Press,
    Release,
    Hold,
};

pub const MouseButtonAction = KeyAction;
// impl KeyAction {
//     #[inline]
//     pub fn is_press(&self) -> bool {
//         return *self == KeyAction::Press;
//     }
//
//     #[inline]
//     pub fn is_release(&self) -> bool {
//         return !self.is_press();
//     }
// }

pub const MouseButton = enum(u8) {
    Left = 0, // Left Mouse Button.
    Right, // Right Mouse Button.
    Middle, // Middle Mouse Button.
    ExtraButton1, // Additional Mouse Button 1 (backward navigation).
    ExtraButton2, // Additional Mouse Button 2 (forward navigation).
    MOUSE_BUTTONS_NUMBER,
};

pub const MouseWheel = enum(u1) {
    VerticalWheel,
    HorizontalWheel,
};

//  MouseWheel {
//     pub fn is_vertical(&self) -> bool {
//         *self == MouseWheel::VerticalWheel
//     }
//
//     pub fn is_horizontal(&self) -> bool {
//         *self == MouseWheel::HorizontalWheel
//     }
// }

pub const InputState = struct {
    keys: [@enumToInt(ScanCode.NUMBER_OF_KEYS)]KeyAction,
    mouse_buttons: [@enumToInt(MouseButton.MOUSE_BUTTONS_NUMBER)]MouseButtonAction,
    const Self = @This();
    pub fn init() Self {
        return Self{
            .keys = [@enumToInt(ScanCode.NUMBER_OF_KEYS)]KeyAction{KeyAction.Release},
            .mouse_buttons = [@enumToInt(MouseButton.MOUSE_BUTTONS_NUMBER)]KeyAction{KeyAction.Release},
        };
    }
};

// impl Default for InputState {
//     fn default() -> Self {
//         Self {
//             keys: [KeyAction::Release; NUMBER_OF_KEYS],
//             mouse_buttons: [KeyAction::Release; MOUSE_BUTTONS_NUMBER],
//         }
//     }
// }

