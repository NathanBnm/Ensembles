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
    public class VoiceItem : Gtk.ListBoxRow {
        public Ensembles.Core.Voice voice;
        public VoiceItem (Ensembles.Core.Voice voice, bool show_category) {
            this.voice = voice;

            var voice_label = new Gtk.Label (voice.name);
            voice_label.get_style_context ().add_class ("menu-item-label");
            voice_label.halign = Gtk.Align.START;
            voice_label.hexpand = true;

            var bank_preset_label = new Gtk.Label (voice.bank.to_string () + " ┅ " + voice.preset.to_string ());
            bank_preset_label.get_style_context ().add_class ("menu-item-description");
            bank_preset_label.halign = Gtk.Align.END;
            var category_label = new Gtk.Label ("");
            var voice_grid = new Gtk.Grid ();
            if (show_category) {
                category_label.set_text (voice.category);
                category_label.get_style_context ().add_class ("menu-item-annotation");
            }
            try {
                Gdk.Pixbuf thumb = new Gdk.Pixbuf.from_file (Constants.PKGDATADIR +
                                                             "/Instruments/" +
                                                             voice.name +
                                                             ".jpg");
                thumb = thumb.scale_simple (54, 36, Gdk.InterpType.NEAREST);
                var image = new Gtk.Image.from_pixbuf (thumb);
                image.margin_end = 8;
                voice_grid.attach (image, 0, 0, 1, 2);
            } catch (Error e) {
                try {
                    Gdk.Pixbuf thumb = new Gdk.Pixbuf.from_file (Constants.PKGDATADIR +
                                                                 "/Instruments/" +
                                                                 voice.category.replace ("/", "_") +
                                                                 ".jpg");
                    thumb = thumb.scale_simple (54, 36, Gdk.InterpType.NEAREST);
                    var image = new Gtk.Image.from_pixbuf (thumb);
                    image.margin_end = 8;
                    voice_grid.attach (image, 0, 0, 1, 2);
                } catch (Error e) {
                    // Ignore
                }
            }
            voice_grid.attach (voice_label, 1, 0, 1, 2);
            voice_grid.attach (category_label, 2, 0, 1, 1);
            voice_grid.attach (bank_preset_label, 2, 1, 1, 1);
            this.add (voice_grid);
        }
    }
}
