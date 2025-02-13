/*-
 * Copyright (c) 2021-2022 Subhadeep Jasu <subhajasu@gmail.com>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public
 * License as published by the Free Software Foundation; either
 * version 3 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License 
 * along with this program. If not, see <https://www.gnu.org/licenses/>.
 *
 * Authored by: Subhadeep Jasu <subhajasu@gmail.com>
 */

namespace Ensembles.Shell {
    public class ChannelModulatorScreen : Gtk.Grid {
        int _synth_index;
        int _channel;

        public signal void close_screen ();
        Gtk.Label header;

        bool monitoring;


        // Spin Buttons
        Gtk.SpinButton pan_spin_button;
        Gtk.SpinButton reverb_spin_button;
        Gtk.SpinButton chorus_spin_button;
        Gtk.SpinButton pitch_spin_button;
        Gtk.SpinButton expression_spin_button;
        Gtk.SpinButton modulation_spin_button;
        Gtk.SpinButton cut_off_spin_button;
        Gtk.SpinButton resonance_spin_button;

        Gtk.Button pan_button;
        Gtk.Button reverb_button;
        Gtk.Button chorus_button;
        Gtk.Button pitch_button;
        Gtk.Button expression_button;
        Gtk.Button modulation_button;
        Gtk.Button cut_off_button;
        Gtk.Button resonance_button;

        bool pan_lock;
        bool reverb_lock;
        bool chorus_lock;
        bool pitch_lock;
        bool expression_lock;
        bool modulation_lock;
        bool cut_off_lock;
        bool resonance_lock;

        bool assignable;

        public signal void broadcast_assignment (int synth_index, int channel, int modulator);

        public ChannelModulatorScreen (int synth_index, int channel) {
            _synth_index = synth_index;
            _channel = channel;
            set_size_request (424, 236);
            row_spacing = 8;
            get_style_context ().add_class ("channel-modulator-screen");

            var close_button = new Gtk.Button.from_icon_name ("window-close-symbolic", Gtk.IconSize.BUTTON);
            close_button.get_style_context ().add_class ("channel-modulator-close-button");
            close_button.clicked.connect (() => {
                monitoring = false;
                close_screen ();
            });
            attach (close_button, 0, 0, 1, 1);

            header = new Gtk.Label ("");
            header.get_style_context ().add_class ("channel-modulator-header");
            header.halign = Gtk.Align.START;
            header.hexpand = true;
            attach (header, 1, 0, 1, 1);

            var mod_grid = new Gtk.Grid ();
            mod_grid.column_homogeneous = true;
            mod_grid.column_spacing = 6;

            mod_grid.get_style_context ().add_class ("channel-modulator-grid");

            pan_button = new Gtk.Button.with_label ("Pan");
            pan_button.get_style_context ().add_class ("channel-modulator-button");
            pan_spin_button = new Gtk.SpinButton.with_range (-64, 63, 1);
            pan_button.vexpand = true;
            pan_spin_button.vexpand = true;
            mod_grid.attach (pan_button, 0, 0, 2, 1);
            mod_grid.attach (pan_spin_button, 0, 1, 2, 1);

            reverb_button = new Gtk.Button.with_label ("Reverb");
            reverb_button.get_style_context ().add_class ("channel-modulator-button");
            reverb_spin_button = new Gtk.SpinButton.with_range (0, 127, 1);
            reverb_button.vexpand = true;
            reverb_spin_button.vexpand = true;
            mod_grid.attach (reverb_button, 2, 0, 2, 1);
            mod_grid.attach (reverb_spin_button, 2, 1, 2, 1);

            chorus_button = new Gtk.Button.with_label ("Chorus");
            chorus_button.get_style_context ().add_class ("channel-modulator-button");
            chorus_spin_button = new Gtk.SpinButton.with_range (0, 127, 1);
            chorus_button.vexpand = true;
            chorus_spin_button.vexpand = true;
            mod_grid.attach (chorus_button, 4, 0, 2, 1);
            mod_grid.attach (chorus_spin_button, 4, 1, 2, 1);

            pitch_button = new Gtk.Button.with_label ("Pitch");
            pitch_button.get_style_context ().add_class ("channel-modulator-button");
            pitch_spin_button = new Gtk.SpinButton.with_range (-64, 63, 1);
            pitch_spin_button.vexpand = true;
            pan_spin_button.vexpand = true;
            mod_grid.attach (pitch_button, 6, 0, 2, 1);
            mod_grid.attach (pitch_spin_button, 6, 1, 2, 1);

            expression_button = new Gtk.Button.with_label ("Expression");
            expression_button.get_style_context ().add_class ("channel-modulator-button");
            expression_spin_button = new Gtk.SpinButton.with_range (0, 127, 1);
            expression_button.vexpand = true;
            expression_spin_button.vexpand = true;
            mod_grid.attach (expression_button, 0, 2, 2, 1);
            mod_grid.attach (expression_spin_button, 0, 3, 2, 1);

            modulation_button = new Gtk.Button.with_label ("Modulation");
            modulation_button.get_style_context ().add_class ("channel-modulator-button");
            modulation_spin_button = new Gtk.SpinButton.with_range (0, 127, 1);
            modulation_button.vexpand = true;
            modulation_spin_button.vexpand = true;
            mod_grid.attach (modulation_button, 2, 2, 2, 1);
            mod_grid.attach (modulation_spin_button, 2, 3, 2, 1);

            cut_off_button = new Gtk.Button.with_label ("Cut Off");
            cut_off_button.get_style_context ().add_class ("channel-modulator-button");
            cut_off_spin_button = new Gtk.SpinButton.with_range (0, 127, 1);
            cut_off_button.vexpand = true;
            cut_off_spin_button.vexpand = true;
            mod_grid.attach (cut_off_button, 4, 2, 2, 1);
            mod_grid.attach (cut_off_spin_button, 4, 3, 2, 1);

            resonance_button = new Gtk.Button.with_label ("Resonance");
            resonance_button.get_style_context ().add_class ("channel-modulator-button");
            resonance_spin_button = new Gtk.SpinButton.with_range (0, 127, 1);
            resonance_button.vexpand = true;
            resonance_spin_button.vexpand = true;
            mod_grid.attach (resonance_button, 6, 2, 2, 1);
            mod_grid.attach (resonance_spin_button, 6, 3, 2, 1);

            attach (mod_grid, 0, 1, 2, 1);
            show_all ();

            make_events ();
        }

        public void set_synth_channel_to_edit (int synth_index, int channel) {
            _synth_index = synth_index;
            _channel = channel;
            if (synth_index == 0) {
                switch (channel) {
                    case 0:
                    header.set_text ("Voice Right 1 Modulators");
                    break;
                    case 1:
                    header.set_text ("Voice Right 2 Modulators");
                    break;
                    case 2:
                    header.set_text ("Voice Left Modulators");
                    break;
                }
            } else {
                header.set_text ("Style Channel " + (channel + 1).to_string () + " Modulators");
            }
            modulation_button.get_style_context ().remove_class ("channel-modulator-lock");
            pan_button.get_style_context ().remove_class ("channel-modulator-lock");
            expression_button.get_style_context ().remove_class ("channel-modulator-lock");
            pitch_button.get_style_context ().remove_class ("channel-modulator-lock");
            resonance_button.get_style_context ().remove_class ("channel-modulator-lock");
            cut_off_button.get_style_context ().remove_class ("channel-modulator-lock");
            reverb_button.get_style_context ().remove_class ("channel-modulator-lock");
            chorus_button.get_style_context ().remove_class ("channel-modulator-lock");
            if (_synth_index == 1) {
                if (Ensembles.Core.Synthesizer.get_modulator_lock (1, _channel) == true) {
                    modulation_button.get_style_context ().add_class ("channel-modulator-lock");
                }
                if (Ensembles.Core.Synthesizer.get_modulator_lock (10, _channel) == true) {
                    pan_button.get_style_context ().add_class ("channel-modulator-lock");
                }
                if (Ensembles.Core.Synthesizer.get_modulator_lock (11, _channel) == true) {
                    expression_button.get_style_context ().add_class ("channel-modulator-lock");
                }
                if (Ensembles.Core.Synthesizer.get_modulator_lock (3, _channel) == true) {
                    pitch_button.get_style_context ().add_class ("channel-modulator-lock");
                }
                if (Ensembles.Core.Synthesizer.get_modulator_lock (71, _channel) == true) {
                    resonance_button.get_style_context ().add_class ("channel-modulator-lock");
                }
                if (Ensembles.Core.Synthesizer.get_modulator_lock (74, _channel) == true) {
                    cut_off_button.get_style_context ().add_class ("channel-modulator-lock");
                }
                if (Ensembles.Core.Synthesizer.get_modulator_lock (91, _channel) == true) {
                    reverb_button.get_style_context ().add_class ("channel-modulator-lock");
                }
                if (Ensembles.Core.Synthesizer.get_modulator_lock (66, _channel) == true) {
                    chorus_button.get_style_context ().add_class ("channel-modulator-lock");
                }
            }
            monitor_modulators ();
        }

        void monitor_modulators () {
            monitoring = true;
            Timeout.add (200, () => {
                pan_lock = false;
                pan_spin_button.value = (double)(Ensembles.Core.Synthesizer.get_modulator_value (_synth_index, _channel, 10)) - 64;
                pan_lock = true;
                reverb_lock = false;
                reverb_spin_button.value = (double)(Ensembles.Core.Synthesizer.get_modulator_value (_synth_index, _channel, 91));
                reverb_lock = true;
                chorus_lock = false;
                chorus_spin_button.value = (double)(Ensembles.Core.Synthesizer.get_modulator_value (_synth_index, _channel, 93));
                chorus_lock = true;
                pitch_lock = false;
                pitch_spin_button.value = (double)(Ensembles.Core.Synthesizer.get_modulator_value (_synth_index, _channel, 3)) - 64;
                pitch_lock = true;
                expression_lock = false;
                expression_spin_button.value = (double)(Ensembles.Core.Synthesizer.get_modulator_value (_synth_index, _channel, 11));
                expression_lock = true;
                modulation_lock = false;
                modulation_spin_button.value = (double)(Ensembles.Core.Synthesizer.get_modulator_value (_synth_index, _channel, 1));
                modulation_lock = true;
                cut_off_lock = false;
                cut_off_spin_button.value = (double)(Ensembles.Core.Synthesizer.get_modulator_value (_synth_index, _channel, 74));
                cut_off_lock = true;
                resonance_lock = false;
                resonance_spin_button.value = (double)(Ensembles.Core.Synthesizer.get_modulator_value (_synth_index, _channel, 71));
                resonance_lock = true;
                return monitoring;
            });
        }

        void make_events () {
            modulation_spin_button.value_changed.connect (() => {
                if (modulation_lock) {
                    Ensembles.Core.Synthesizer.set_modulator_value (_synth_index, _channel, 1, (int)modulation_spin_button.value);
                    if (_synth_index == 1) {
                        modulation_button.get_style_context ().add_class ("channel-modulator-lock");
                    }
                }
            });
            pan_spin_button.value_changed.connect (() => {
                if (pan_lock) {
                    Ensembles.Core.Synthesizer.set_modulator_value (_synth_index, _channel, 10, (int)pan_spin_button.value + 64);
                    if (_synth_index == 1) {
                        pan_button.get_style_context ().add_class ("channel-modulator-lock");
                    }
                }
            });
            expression_spin_button.value_changed.connect (() => {
                if (expression_lock) {
                    Ensembles.Core.Synthesizer.set_modulator_value (_synth_index, _channel, 11, (int)expression_spin_button.value);
                    if (_synth_index == 1) {
                        expression_button.get_style_context ().add_class ("channel-modulator-lock");
                    }
                }
            });
            pitch_spin_button.value_changed.connect (() => {
                if (pitch_lock) {
                    Ensembles.Core.Synthesizer.set_modulator_value (_synth_index, _channel, 3, (int)pitch_spin_button.value + 64);
                    if (_synth_index == 1) {
                        pitch_button.get_style_context ().add_class ("channel-modulator-lock");
                    }
                }
            });
            resonance_spin_button.value_changed.connect (() => {
                if (resonance_lock) {
                    Ensembles.Core.Synthesizer.set_modulator_value (_synth_index, _channel, 71, (int)resonance_spin_button.value);
                    if (_synth_index == 1) {
                        resonance_button.get_style_context ().add_class ("channel-modulator-lock");
                    }
                }
            });
            cut_off_spin_button.value_changed.connect (() => {
                if (cut_off_lock) {
                    Ensembles.Core.Synthesizer.set_modulator_value (_synth_index, _channel, 74, (int)cut_off_spin_button.value);
                    if (_synth_index == 1) {
                        cut_off_button.get_style_context ().add_class ("channel-modulator-lock");
                    }
                }
            });
            reverb_spin_button.value_changed.connect (() => {
                if (reverb_lock) {
                    Ensembles.Core.Synthesizer.set_modulator_value (_synth_index, _channel, 91, (int)reverb_spin_button.value);
                    if (_synth_index == 1) {
                        reverb_button.get_style_context ().add_class ("channel-modulator-lock");
                    }
                }
            });
            chorus_spin_button.value_changed.connect (() => {
                if (chorus_lock) {
                    Ensembles.Core.Synthesizer.set_modulator_value (_synth_index, _channel, 93, (int)chorus_spin_button.value);
                    if (_synth_index == 1) {
                        chorus_button.get_style_context ().add_class ("channel-modulator-lock");
                    }
                }
            });
            modulation_button.button_release_event.connect ((event) => {
                if (event.button == 3 && _synth_index == 1) {
                    Ensembles.Core.Synthesizer.lock_modulator (1, _channel);
                    modulation_button.get_style_context ().remove_class ("channel-modulator-lock");
                } else if (event.button == 1 && assignable) {
                    broadcast_assignment (_synth_index, _channel, 1);
                }
                return false;
            });
            pan_button.button_release_event.connect ((event) => {
                if (event.button == 3 && _synth_index == 1) {
                    Ensembles.Core.Synthesizer.lock_modulator (10, _channel);
                    pan_button.get_style_context ().remove_class ("channel-modulator-lock");
                } else if (event.button == 1 && assignable) {
                    broadcast_assignment (_synth_index, _channel, 10);
                }
                return false;
            });
            expression_button.button_release_event.connect ((event) => {
                if (event.button == 3 && _synth_index == 1) {
                    Ensembles.Core.Synthesizer.lock_modulator (11, _channel);
                    expression_button.get_style_context ().remove_class ("channel-modulator-lock");
                } else if (event.button == 1 && assignable) {
                    broadcast_assignment (_synth_index, _channel, 11);
                }
                return false;
            });
            pitch_button.button_release_event.connect ((event) => {
                if (event.button == 3 && _synth_index == 1) {
                    Ensembles.Core.Synthesizer.lock_modulator (3, _channel);
                    pitch_button.get_style_context ().remove_class ("channel-modulator-lock");
                } else if (event.button == 1 && assignable) {
                    broadcast_assignment (_synth_index, _channel, 3);
                }
                return false;
            });
            resonance_button.button_release_event.connect ((event) => {
                if (event.button == 3 && _synth_index == 1) {
                    Ensembles.Core.Synthesizer.lock_modulator (71, _channel);
                    resonance_button.get_style_context ().remove_class ("channel-modulator-lock");
                } else if (event.button == 1 && assignable) {
                    broadcast_assignment (_synth_index, _channel, 71);
                }
                return false;
            });
            cut_off_button.button_release_event.connect ((event) => {
                if (event.button == 3 && _synth_index == 1) {
                    Ensembles.Core.Synthesizer.lock_modulator (74, _channel);
                    cut_off_button.get_style_context ().remove_class ("channel-modulator-lock");
                } else if (event.button == 1 && assignable) {
                    broadcast_assignment (_synth_index, _channel, 74);
                }
                return false;
            });
            reverb_button.button_release_event.connect ((event) => {
                if (event.button == 3 && _synth_index == 1) {
                    Ensembles.Core.Synthesizer.lock_modulator (91, _channel);
                    reverb_button.get_style_context ().remove_class ("channel-modulator-lock");
                } else if (event.button == 1 && assignable) {
                    broadcast_assignment (_synth_index, _channel, 91);
                }
                return false;
            });
            chorus_button.button_release_event.connect ((event) => {
                if (event.button == 3 && _synth_index == 1) {
                    Ensembles.Core.Synthesizer.lock_modulator (93, _channel);
                    chorus_button.get_style_context ().remove_class ("channel-modulator-lock");
                } else if (event.button == 1 && assignable) {
                    broadcast_assignment (_synth_index, _channel, 93);
                }
                return false;
            });
        }

        public void set_assignable (bool assignable) {
            this.assignable = assignable;
            if (assignable) {
                modulation_button.get_style_context ().add_class ("channel-modulator-assignable");
                pan_button.get_style_context ().add_class ("channel-modulator-assignable");
                expression_button.get_style_context ().add_class ("channel-modulator-assignable");
                pitch_button.get_style_context ().add_class ("channel-modulator-assignable");
                resonance_button.get_style_context ().add_class ("channel-modulator-assignable");
                cut_off_button.get_style_context ().add_class ("channel-modulator-assignable");
                reverb_button.get_style_context ().add_class ("channel-modulator-assignable");
                chorus_button.get_style_context ().add_class ("channel-modulator-assignable");
            } else {
                modulation_button.get_style_context ().remove_class ("channel-modulator-assignable");
                pan_button.get_style_context ().remove_class ("channel-modulator-assignable");
                expression_button.get_style_context ().remove_class ("channel-modulator-assignable");
                pitch_button.get_style_context ().remove_class ("channel-modulator-assignable");
                resonance_button.get_style_context ().remove_class ("channel-modulator-assignable");
                cut_off_button.get_style_context ().remove_class ("channel-modulator-assignable");
                reverb_button.get_style_context ().remove_class ("channel-modulator-assignable");
                chorus_button.get_style_context ().remove_class ("channel-modulator-assignable");
            }
            set_synth_channel_to_edit (_synth_index, _channel);
        }
    }
}
