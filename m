Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8F0C433F5
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 00:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbiC2Ao1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 20:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbiC2AoW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 20:44:22 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FE2239328
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 17:42:40 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r7so21482801wrc.0
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 17:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QWCWFNWsBB6VcLQ3/PKqrQkuCpYYV6HLUH3YP6F+dLc=;
        b=i4voaN2YGFacF1PofY7ca4OgTk8iunIPd1tJ7Z7/El4wzvItD0sk1mVXGuHnjp9jX7
         M6ImI/c+ALUILZL4ABgSTCTk9p7cpuwkvW9MMMjBxb+8WwnksK0WpliArk18hgXkiStW
         KASZkbKuJckV0Cg11RiV/s3DHzSe15Yrg9reHeEVR7bOId0+IMmICPmB9n0zUgfGP7We
         srHhKaFK+Tcxgl3mRkJCdO0PfdgJzkkXYI/MUB1KFgvh7vVuwtcXB15rcn0jj2PGWYOv
         vWzItGwczjGcNl+pVjmJ+RfXZLyntD5G1HChBX3uJtdbi0HXMufTST60cb8iimINxgwc
         JdJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QWCWFNWsBB6VcLQ3/PKqrQkuCpYYV6HLUH3YP6F+dLc=;
        b=aP1whfzr8BTTGUm3JSWABqCZPUavl12FBYWN48hlIwmiRDsL2KbB6jvfmRTNZJOdRL
         iAAxdKqml1x/j/UIVCoIEn2ttp7HRbrcZg/P1sYOaNmXBYQa3NQimmrIiVURakd73WGC
         ainHCA2YDXjuy+vZCxr+uOOnAxI34F8v6K+zeFtVapO41vLB0DKNzfv+GFmKE3zrFiKe
         FA8cZ76kWBxiryK3Ar/IBgFxpmQW4lOcglzhHJxIVdpkDrxF1Xn3rnauaMy55PEXrHkf
         6qVK+d8Nn8DYwxlKcNfN7iXmU0j2d8PLhXSofFsOiW8RKOjOeVvK9u1wxAU9m4S5Cng3
         t0xw==
X-Gm-Message-State: AOAM533R2120DNrSU22vnaC9/VJRuvlD6XOQlRKRkTpJ9QLi9FXPNlp1
        Ec9+Nd5/FBEMiW/+W+Z13VZ85QU408k=
X-Google-Smtp-Source: ABdhPJziNs+OLJu46uRsYwBM4HpMFI+HXeYX2VwtCgsIZrizt4k0EMBbkArzIQ6KzD4GDUvp2mnrfw==
X-Received: by 2002:adf:f84c:0:b0:203:f4b9:4213 with SMTP id d12-20020adff84c000000b00203f4b94213mr26408480wrq.27.1648514558363;
        Mon, 28 Mar 2022 17:42:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e8-20020a05600c2dc800b0038d05f2b34dsm1244475wmh.2.2022.03.28.17.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 17:42:37 -0700 (PDT)
Message-Id: <9e7ae22fa4a2693fe26659f875dd780080c4cfb2.1648514553.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
References: <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com>
        <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Mar 2022 00:42:21 +0000
Subject: [PATCH v4 04/13] core.fsyncmethod: batched disk flushes for
 loose-objects
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, nksingh85@gmail.com,
        ps@pks.im, jeffhost@microsoft.com,
        Bagas Sanjaya <bagasdotme@gmail.com>, worldhello.net@gmail.com,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

When adding many objects to a repo with `core.fsync=loose-object`,
the cost of fsync'ing each object file can become prohibitive.

One major source of the cost of fsync is the implied flush of the
hardware writeback cache within the disk drive. This commit introduces
a new `core.fsyncMethod=batch` option that batches up hardware flushes.
It hooks into the bulk-checkin odb-transaction functionality, takes
advantage of tmp-objdir, and uses the writeout-only support code.

When the new mode is enabled, we do the following for each new object:
1a. Create the object in a tmp-objdir.
2a. Issue a pagecache writeback request and wait for it to complete.

At the end of the entire transaction when unplugging bulk checkin:
1b. Issue an fsync against a dummy file to flush the log and hardware
   writeback cache, which should by now have seen the tmp-objdir writes.
2b. Rename all of the tmp-objdir files to their final names.
3b. When updating the index and/or refs, we assume that Git will issue
   another fsync internal to that operation. This is not the default
   today, but the user now has the option of syncing the index and there
   is a separate patch series to implement syncing of refs.

On a filesystem with a singular journal that is updated during name
operations (e.g. create, link, rename, etc), such as NTFS, HFS+, or XFS
we would expect the fsync to trigger a journal writeout so that this
sequence is enough to ensure that the user's data is durable by the time
the git command returns. This sequence also ensures that no object files
appear in the main object store unless they are fsync-durable.

Batch mode is only enabled if core.fsync includes loose-objects. If
the legacy core.fsyncObjectFiles setting is enabled, but core.fsync does
not include loose-objects, we will use file-by-file fsyncing.

In step (1a) of the sequence, the tmp-objdir is created lazily to avoid
work if no loose objects are ever added to the ODB. We use a tmp-objdir
to maintain the invariant that no loose-objects are visible in the main
ODB unless they are properly fsync-durable. This is important since
future ODB operations that try to create an object with specific
contents will silently drop the new data if an object with the target
hash exists without checking that the loose-object contents match the
hash. Only a full git-fsck would restore the ODB to a functional state
where dataloss doesn't occur.

In step (1b) of the sequence, we issue a fsync against a dummy file
created specifically for the purpose. This method has a little higher
cost than using one of the input object files, but makes adding new
callers of this mechanism easier, since we don't need to figure out
which object file is "last" or risk sharing violations by caching the fd
of the last object file.

_Performance numbers_:

Linux - Hyper-V VM running Kernel 5.11 (Ubuntu 20.04) on a fast SSD.
Mac - macOS 11.5.1 running on a Mac mini on a 1TB Apple SSD.
Windows - Same host as Linux, a preview version of Windows 11.

Adding 500 files to the repo with 'git add' Times reported in seconds.

object file syncing | Linux | Mac   | Windows
--------------------|-------|-------|--------
           disabled | 0.06  |  0.35 | 0.61
              fsync | 1.88  | 11.18 | 2.47
              batch | 0.15  |  0.41 | 1.53

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 Documentation/config/core.txt |  8 ++++
 bulk-checkin.c                | 71 +++++++++++++++++++++++++++++++++++
 bulk-checkin.h                |  3 ++
 cache.h                       |  8 +++-
 config.c                      |  2 +
 object-file.c                 |  7 +++-
 6 files changed, 97 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 9da3e5d88f6..3c90ba0b395 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -596,6 +596,14 @@ core.fsyncMethod::
 * `writeout-only` issues pagecache writeback requests, but depending on the
   filesystem and storage hardware, data added to the repository may not be
   durable in the event of a system crash. This is the default mode on macOS.
+* `batch` enables a mode that uses writeout-only flushes to stage multiple
+  updates in the disk writeback cache and then does a single full fsync of
+  a dummy file to trigger the disk cache flush at the end of the operation.
++
+  Currently `batch` mode only applies to loose-object files. Other repository
+  data is made durable as if `fsync` was specified. This mode is expected to
+  be as safe as `fsync` on macOS for repos stored on HFS+ or APFS filesystems
+  and on Windows for repos stored on NTFS or ReFS filesystems.
 
 core.fsyncObjectFiles::
 	This boolean will enable 'fsync()' when writing object files.
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 8b0fd5c7723..9799d247cad 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -3,15 +3,20 @@
  */
 #include "cache.h"
 #include "bulk-checkin.h"
+#include "lockfile.h"
 #include "repository.h"
 #include "csum-file.h"
 #include "pack.h"
 #include "strbuf.h"
+#include "string-list.h"
+#include "tmp-objdir.h"
 #include "packfile.h"
 #include "object-store.h"
 
 static int odb_transaction_nesting;
 
+static struct tmp_objdir *bulk_fsync_objdir;
+
 static struct bulk_checkin_state {
 	char *pack_tmp_name;
 	struct hashfile *f;
@@ -80,6 +85,40 @@ clear_exit:
 	reprepare_packed_git(the_repository);
 }
 
+/*
+ * Cleanup after batch-mode fsync_object_files.
+ */
+static void do_batch_fsync(void)
+{
+	struct strbuf temp_path = STRBUF_INIT;
+	struct tempfile *temp;
+
+	if (!bulk_fsync_objdir)
+		return;
+
+	/*
+	 * Issue a full hardware flush against a temporary file to ensure
+	 * that all objects are durable before any renames occur. The code in
+	 * fsync_loose_object_bulk_checkin has already issued a writeout
+	 * request, but it has not flushed any writeback cache in the storage
+	 * hardware or any filesystem logs. This fsync call acts as a barrier
+	 * to ensure that the data in each new object file is durable before
+	 * the final name is visible.
+	 */
+	strbuf_addf(&temp_path, "%s/bulk_fsync_XXXXXX", get_object_directory());
+	temp = xmks_tempfile(temp_path.buf);
+	fsync_or_die(get_tempfile_fd(temp), get_tempfile_path(temp));
+	delete_tempfile(&temp);
+	strbuf_release(&temp_path);
+
+	/*
+	 * Make the object files visible in the primary ODB after their data is
+	 * fully durable.
+	 */
+	tmp_objdir_migrate(bulk_fsync_objdir);
+	bulk_fsync_objdir = NULL;
+}
+
 static int already_written(struct bulk_checkin_state *state, struct object_id *oid)
 {
 	int i;
@@ -274,6 +313,36 @@ static int deflate_to_pack(struct bulk_checkin_state *state,
 	return 0;
 }
 
+void prepare_loose_object_bulk_checkin(void)
+{
+	/*
+	 * We lazily create the temporary object directory
+	 * the first time an object might be added, since
+	 * callers may not know whether any objects will be
+	 * added at the time they call begin_odb_transaction.
+	 */
+	if (!odb_transaction_nesting || bulk_fsync_objdir)
+		return;
+
+	bulk_fsync_objdir = tmp_objdir_create("bulk-fsync");
+	if (bulk_fsync_objdir)
+		tmp_objdir_replace_primary_odb(bulk_fsync_objdir, 0);
+}
+
+void fsync_loose_object_bulk_checkin(int fd, const char *filename)
+{
+	/*
+	 * If we have an active ODB transaction, we issue a call that
+	 * cleans the filesystem page cache but avoids a hardware flush
+	 * command. Later on we will issue a single hardware flush
+	 * before as part of do_batch_fsync.
+	 */
+	if (!bulk_fsync_objdir ||
+	    git_fsync(fd, FSYNC_WRITEOUT_ONLY) < 0) {
+		fsync_or_die(fd, filename);
+	}
+}
+
 int index_bulk_checkin(struct object_id *oid,
 		       int fd, size_t size, enum object_type type,
 		       const char *path, unsigned flags)
@@ -301,4 +370,6 @@ void end_odb_transaction(void)
 
 	if (bulk_checkin_state.f)
 		finish_bulk_checkin(&bulk_checkin_state);
+
+	do_batch_fsync();
 }
diff --git a/bulk-checkin.h b/bulk-checkin.h
index 69a94422ac7..70edf745be8 100644
--- a/bulk-checkin.h
+++ b/bulk-checkin.h
@@ -6,6 +6,9 @@
 
 #include "cache.h"
 
+void prepare_loose_object_bulk_checkin(void);
+void fsync_loose_object_bulk_checkin(int fd, const char *filename);
+
 int index_bulk_checkin(struct object_id *oid,
 		       int fd, size_t size, enum object_type type,
 		       const char *path, unsigned flags);
diff --git a/cache.h b/cache.h
index ef7d34b7a09..a5bf15a5131 100644
--- a/cache.h
+++ b/cache.h
@@ -1040,7 +1040,8 @@ extern int use_fsync;
 
 enum fsync_method {
 	FSYNC_METHOD_FSYNC,
-	FSYNC_METHOD_WRITEOUT_ONLY
+	FSYNC_METHOD_WRITEOUT_ONLY,
+	FSYNC_METHOD_BATCH,
 };
 
 extern enum fsync_method fsync_method;
@@ -1767,6 +1768,11 @@ void fsync_or_die(int fd, const char *);
 int fsync_component(enum fsync_component component, int fd);
 void fsync_component_or_die(enum fsync_component component, int fd, const char *msg);
 
+static inline int batch_fsync_enabled(enum fsync_component component)
+{
+	return (fsync_components & component) && (fsync_method == FSYNC_METHOD_BATCH);
+}
+
 ssize_t read_in_full(int fd, void *buf, size_t count);
 ssize_t write_in_full(int fd, const void *buf, size_t count);
 ssize_t pread_in_full(int fd, void *buf, size_t count, off_t offset);
diff --git a/config.c b/config.c
index 3c9b6b589ab..511f4584eeb 100644
--- a/config.c
+++ b/config.c
@@ -1688,6 +1688,8 @@ static int git_default_core_config(const char *var, const char *value, void *cb)
 			fsync_method = FSYNC_METHOD_FSYNC;
 		else if (!strcmp(value, "writeout-only"))
 			fsync_method = FSYNC_METHOD_WRITEOUT_ONLY;
+		else if (!strcmp(value, "batch"))
+			fsync_method = FSYNC_METHOD_BATCH;
 		else
 			warning(_("ignoring unknown core.fsyncMethod value '%s'"), value);
 
diff --git a/object-file.c b/object-file.c
index 5ffbf3d4fd4..d2e0c13198f 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1893,7 +1893,9 @@ static void close_loose_object(int fd, const char *filename)
 	if (the_repository->objects->odb->will_destroy)
 		goto out;
 
-	if (fsync_object_files > 0)
+	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
+		fsync_loose_object_bulk_checkin(fd, filename);
+	else if (fsync_object_files > 0)
 		fsync_or_die(fd, filename);
 	else
 		fsync_component_or_die(FSYNC_COMPONENT_LOOSE_OBJECT, fd,
@@ -1961,6 +1963,9 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 	static struct strbuf tmp_file = STRBUF_INIT;
 	static struct strbuf filename = STRBUF_INIT;
 
+	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
+		prepare_loose_object_bulk_checkin();
+
 	loose_object_path(the_repository, &filename, oid);
 
 	fd = create_tmpfile(&tmp_file, filename.buf);
-- 
gitgitgadget

