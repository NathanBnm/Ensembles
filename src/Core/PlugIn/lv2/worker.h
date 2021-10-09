/*
  Copyright 2007-2016 David Robillard <d@drobilla.net>

  Permission to use, copy, modify, and/or distribute this software for any
  purpose with or without fee is hereby granted, provided that the above
  copyright notice and this permission notice appear in all copies.

  THIS SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
  ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
*/

#include "lv2_host.h"

#include "lilv/lilv.h"
#include "lv2/worker/worker.h"

#include <stdbool.h>
#include <stdint.h>

void
lv2_host_worker_init(Ensembles_LV2_Host*                       lv2_host,
                 Ensembles_LV2_HostWorker*                 worker,
                 const LV2_Worker_Interface* iface,
                 bool                        threaded);

void
lv2_host_worker_finish(Ensembles_LV2_HostWorker* worker);

void
lv2_host_worker_destroy(Ensembles_LV2_HostWorker* worker);

LV2_Worker_Status
lv2_host_worker_schedule(LV2_Worker_Schedule_Handle handle,
                     uint32_t                   size,
                     const void*                data);

void
lv2_host_worker_emit_responses(Ensembles_LV2_HostWorker* worker, LilvInstance* instance);
