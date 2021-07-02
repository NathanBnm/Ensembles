namespace Ensembles.Shell { 
    public class KeyboardView : Gtk.Grid {
        OctaveKeyboard[] octaves;
        Gtk.Box key_grid;
        Gtk.Switch hold_switch;
        Gtk.Switch zoom_switch;
        JoyStick joy_stick;
        Ensembles.Core.Synthesizer _synth;
        public KeyboardView() {
            get_style_context ().add_class ("keyboard-background");
            key_grid = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            //  key_grid.margin_start = 150;

            octaves = new OctaveKeyboard[5];
            for (int i = 0; i < 5; i++) {
                octaves[i] = new OctaveKeyboard (i + 3);
                key_grid.pack_start (octaves[i]);
            }

            var keyboard_scroller = new Gtk.ScrolledWindow (null, null);
            keyboard_scroller.add (key_grid);

            var keyboard_overlay = new Gtk.Overlay ();
            keyboard_overlay.height_request = 170;
            keyboard_overlay.hexpand = true;
            keyboard_overlay.add_overlay (keyboard_scroller);

            zoom_switch = new Gtk.Switch ();
            zoom_switch.margin_start = 8;
            zoom_switch.margin_end = 8;
            zoom_switch.notify["active"].connect (() => {
                toggle_zoom (zoom_switch.active);
            });
            hold_switch = new Gtk.Switch ();
            hold_switch.margin_start = 8;
            hold_switch.margin_end = 14;

            var switch_bar = new Gtk.Grid ();
            switch_bar.halign = Gtk.Align.END;
            switch_bar.hexpand = true;
            switch_bar.margin_top = 1;
            switch_bar.attach (new Gtk.Label ("H O L D"), 0, 0, 1, 1);
            switch_bar.attach (hold_switch, 1, 0, 1, 1);
            switch_bar.attach (new Gtk.Label ("Z O O M"), 2, 0, 1, 1);
            switch_bar.attach (zoom_switch, 3, 0, 1, 1);

            var keyboard_top_bar = new Gtk.Grid ();
            keyboard_top_bar.valign = Gtk.Align.START;
            keyboard_top_bar.height_request = 24;
            keyboard_top_bar.get_style_context ().add_class ("keyboard-top-bar");
            keyboard_top_bar.add (switch_bar);
            
            

            keyboard_overlay.add_overlay (keyboard_top_bar);
            keyboard_overlay.set_overlay_pass_through (keyboard_top_bar, true);

            joy_stick = new JoyStick ();
            add (joy_stick);
            add (keyboard_overlay);
            show_all ();
        }

        public void connect_synthesizer (Ensembles.Core.Synthesizer synth) {
            _synth = synth;
            octaves[0].note_activate.connect ((index, on) => {
                _synth.send_notes_realtime (index + 36, on ? 144 : 128, 100);
            });
            octaves[1].note_activate.connect ((index, on) => {
                _synth.send_notes_realtime (index + 48, on ? 144 : 128, 100);
            });
            octaves[2].note_activate.connect ((index, on) => {
                _synth.send_notes_realtime (index + 60, on ? 144 : 128, 100);
            });
            octaves[3].note_activate.connect ((index, on) => {
                _synth.send_notes_realtime (index + 72, on ? 144 : 128, 100);
            });
            octaves[4].note_activate.connect ((index, on) => {
                _synth.send_notes_realtime (index + 108, on ? 144 : 128, 100);
            });
        }

        public void toggle_zoom (bool active) {
            if (active) {
                key_grid.width_request = 1800;
            } else {
                key_grid.width_request = -1;
            }
        }

        public void set_note_on (int key, bool on) {
            octaves[(int)(key/12) - 3].set_note_on (key % 12, on);
        }

        public void update_split () {
            for (int i = 0; i < 5; i++) {
                octaves[i].update_split ();
            }
        }
    }
}