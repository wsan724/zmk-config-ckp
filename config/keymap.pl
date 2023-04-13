use 5.036;

my @layout=qw(
	ESC N1 N2 N3 N4 N5 N6 N7 N8 N9 N0 MINUS EQUAL BSPC
	TAB Q W E R T Y U I O P LBKT RBKT BSLH
	CAPS A S D F G H J K L SEMI SQT RET
	LSHFT Z X C V B N M COMMA DOT FSLH RSHFT
	LCTRL LCMD LALT SPACE RALT FUNC RCMD RCTRL);

sub layer($h){
	"bindings=<@{[map $h->{$_}//'&trans', @layout]}>;"}

my $base=layer{
	map({;$_,"&kp $_"}@layout),
	CAPS=>'&mo 1',
	FUNC=>'&mo 2', RALT=>'&kp LEFT', RGUI=>'&kp C_MENU', RCTRL=>'&kp RIGHT'};

my $caps=layer{
	map({;"N$_","&kp F$_"}1..9), N0=>'&kp F10', MINUS=>'&kp F11', EQUAL=>'&kp F12', BSPC=>'&kp DEL',
	H=>'&kp LEFT', J=>'&kp DOWN', K=>'&kp UP', L=>'&kp RIGHT', SQT=>'&kp GRAVE', RET=>'&kp INS',
	N=>'&kp HOME', M=>'&kp END', RSHFT=>'&caps_word'};

my $func=layer{
	ESC=>'&bt BT_CLR',
	TAB=>'&bt BT_NXT', Q=>'&kp C_QUIT', P=>'&kp PSCRN',
	A=>'&kp C_VOL_DN', S=>'&kp C_MUTE', D=>'&kp C_VOL_UP', RET=>'&bootloader',
	V=>'&kp C_BRI_DN', B=>'&kp C_BRI_UP',
	SPACE=>'&kp C_PP'};

print <<__;
# include <behaviors.dtsi>
# include <dt-bindings/zmk/keys.h>
# include <dt-bindings/zmk/bt.h>
/{
	keymap{
		compatible="zmk,keymap";
		0{$base};
		1{$caps};
		2{$func};};
};
__
