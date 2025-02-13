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

namespace Ensembles.Core {
    public class StyleAnalyser {
        public int time_sig_n {
            get {
                return time_signature_n;
            }
        }
        public int time_sig_d {
            get {
                return time_signature_d;
            }
        }
        public int analyze_style (string mid_file) {
            return style_analyser_analyze (mid_file);
        }
    }
}

extern int style_analyser_analyze (string mid_file);

extern int time_signature_n;
extern int time_signature_d;
