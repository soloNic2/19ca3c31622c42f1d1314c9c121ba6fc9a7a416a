Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98739C433F5
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 20:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353560AbiBKU4h (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 15:56:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353499AbiBKU4b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 15:56:31 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3838E9E
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:56:29 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d27so17194881wrc.6
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GFmL57kU1ovU8loOoXS499yCe41ToSnzh80WP37lg14=;
        b=XOCZ55J6D5IzR9ahzaJkRGLLWwhHdWb+H5Nm6KbgZT6NxVzHQ4gkQgaR/ssF7M3lm3
         kXDJID/i7eUodtQmKHbBm3WynjzzVmMHYFJSguyrwFhtMmpGPgQ6Ku0b9cZXSBibX9QM
         6CZMMVhIhv+yQfINOVb0gnIz2WB5JoWU9xkeUbzgMGOC+B8z7kkLEP4l0g4Lp3dM3gRL
         QYYtszP3Pxra7OQjA03JZa4jCphClo0Eq/7pSRsp4KQLlEqi1cbuqpcJm1VO1NcjIG4T
         oP6hLWD7lCrQDOsW6XXD3uKyskM+YZXljHR7R547Rd0d8Ed2bz6L1YWh0/R1+PKnhwix
         t1sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GFmL57kU1ovU8loOoXS499yCe41ToSnzh80WP37lg14=;
        b=vGVRb+qoOyz6Tq/tabTvNuRUnwXxHvT3acGBbg1FO6ukLxIqkUAs0CEpdStDG0ztcL
         XeqQR7IC4WUTghLjIZOlfGEvPAKTaxzagIbf3MfS7M8KMLnBhk7zOG6bqrmrvjQokhQS
         hQeXJseB1JzAsqMeZRnaq9faKdcKlcJlGZW4v1UnfA5QwmybZrQsbLyksD0gxyLIeaWR
         ojd2QPj82YEYp+l0i0s3eDNgGt6bqBsULOwoSkHCVMbxmer27QNCAb/JRApApnNhUmPz
         CgKxc0jS1xpEMhpcHpstfOyhdY0NyJ21WUZKPC+pWrCh3eUpPfWgThVO1h0EvQKdZfGw
         5riQ==
X-Gm-Message-State: AOAM532+gDDRwjY5ze6W4udE3RQ+jcPZ/qTP5c+EcF8vtuSzW2YVlyl9
        fk6UohFu3sNnkW8/oWos4jgEr34qv9I=
X-Google-Smtp-Source: ABdhPJzg8BDi+GVgccGomlzoAgOW5huT2IcvM+Bsh7eJPD7Elbgua5QaTrKvtL7wPpXgadokBI2CLg==
X-Received: by 2002:a5d:64e9:: with SMTP id g9mr2745136wri.341.1644612987621;
        Fri, 11 Feb 2022 12:56:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o22sm4727429wmh.13.2022.02.11.12.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 12:56:27 -0800 (PST)
Message-Id: <d6819bdad66628b125f163b62344ef90e720b495.1644612979.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
        <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Feb 2022 20:55:57 +0000
Subject: [PATCH v5 08/30] compat/fsmonitor/fsm-listen-win32: stub in backend
 for Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Stub in empty filesystem listener backend for fsmonitor--daemon on Windows.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 Makefile                            | 13 ++++++++
 compat/fsmonitor/fsm-listen-win32.c | 21 +++++++++++++
 compat/fsmonitor/fsm-listen.h       | 49 +++++++++++++++++++++++++++++
 config.mak.uname                    | 10 ++++++
 contrib/buildsystems/CMakeLists.txt |  7 +++++
 repo-settings.c                     |  1 +
 6 files changed, 101 insertions(+)
 create mode 100644 compat/fsmonitor/fsm-listen-win32.c
 create mode 100644 compat/fsmonitor/fsm-listen.h

diff --git a/Makefile b/Makefile
index 3b7a3f88b50..b98f4899ac0 100644
--- a/Makefile
+++ b/Makefile
@@ -464,6 +464,11 @@ all::
 # directory, and the JSON compilation database 'compile_commands.json' will be
 # created at the root of the repository.
 #
+# If your platform supports a built-in fsmonitor backend, set
+# FSMONITOR_DAEMON_BACKEND to the "<name>" of the corresponding
+# `compat/fsmonitor/fsm-listen-<name>.c` that implements the
+# `fsm_listen__*()` routines.
+#
 # Define DEVELOPER to enable more compiler warnings. Compiler version
 # and family are auto detected, but could be overridden by defining
 # COMPILER_FEATURES (see config.mak.dev). You can still set
@@ -1939,6 +1944,11 @@ ifdef NEED_ACCESS_ROOT_HANDLER
 	COMPAT_OBJS += compat/access.o
 endif
 
+ifdef FSMONITOR_DAEMON_BACKEND
+	COMPAT_CFLAGS += -DHAVE_FSMONITOR_DAEMON_BACKEND
+	COMPAT_OBJS += compat/fsmonitor/fsm-listen-$(FSMONITOR_DAEMON_BACKEND).o
+endif
+
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK = NoThanks
 endif
@@ -2858,6 +2868,9 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo DC_SHA1=\''$(subst ','\'',$(subst ','\'',$(DC_SHA1)))'\' >>$@+
 	@echo SANITIZE_LEAK=\''$(subst ','\'',$(subst ','\'',$(SANITIZE_LEAK)))'\' >>$@+
 	@echo X=\'$(X)\' >>$@+
+ifdef FSMONITOR_DAEMON_BACKEND
+	@echo FSMONITOR_DAEMON_BACKEND=\''$(subst ','\'',$(subst ','\'',$(FSMONITOR_DAEMON_BACKEND)))'\' >>$@+
+endif
 ifdef TEST_OUTPUT_DIRECTORY
 	@echo TEST_OUTPUT_DIRECTORY=\''$(subst ','\'',$(subst ','\'',$(TEST_OUTPUT_DIRECTORY)))'\' >>$@+
 endif
diff --git a/compat/fsmonitor/fsm-listen-win32.c b/compat/fsmonitor/fsm-listen-win32.c
new file mode 100644
index 00000000000..916cbea254f
--- /dev/null
+++ b/compat/fsmonitor/fsm-listen-win32.c
@@ -0,0 +1,21 @@
+#include "cache.h"
+#include "config.h"
+#include "fsmonitor.h"
+#include "fsm-listen.h"
+
+void fsm_listen__stop_async(struct fsmonitor_daemon_state *state)
+{
+}
+
+void fsm_listen__loop(struct fsmonitor_daemon_state *state)
+{
+}
+
+int fsm_listen__ctor(struct fsmonitor_daemon_state *state)
+{
+	return -1;
+}
+
+void fsm_listen__dtor(struct fsmonitor_daemon_state *state)
+{
+}
diff --git a/compat/fsmonitor/fsm-listen.h b/compat/fsmonitor/fsm-listen.h
new file mode 100644
index 00000000000..f0539349baf
--- /dev/null
+++ b/compat/fsmonitor/fsm-listen.h
@@ -0,0 +1,49 @@
+#ifndef FSM_LISTEN_H
+#define FSM_LISTEN_H
+
+/* This needs to be implemented by each backend */
+
+#ifdef HAVE_FSMONITOR_DAEMON_BACKEND
+
+struct fsmonitor_daemon_state;
+
+/*
+ * Initialize platform-specific data for the fsmonitor listener thread.
+ * This will be called from the main thread PRIOR to staring the
+ * fsmonitor_fs_listener thread.
+ *
+ * Returns 0 if successful.
+ * Returns -1 otherwise.
+ */
+int fsm_listen__ctor(struct fsmonitor_daemon_state *state);
+
+/*
+ * Cleanup platform-specific data for the fsmonitor listener thread.
+ * This will be called from the main thread AFTER joining the listener.
+ */
+void fsm_listen__dtor(struct fsmonitor_daemon_state *state);
+
+/*
+ * The main body of the platform-specific event loop to watch for
+ * filesystem events.  This will run in the fsmonitor_fs_listen thread.
+ *
+ * It should call `ipc_server_stop_async()` if the listener thread
+ * prematurely terminates (because of a filesystem error or if it
+ * detects that the .git directory has been deleted).  (It should NOT
+ * do so if the listener thread receives a normal shutdown signal from
+ * the IPC layer.)
+ *
+ * It should set `state->error_code` to -1 if the daemon should exit
+ * with an error.
+ */
+void fsm_listen__loop(struct fsmonitor_daemon_state *state);
+
+/*
+ * Gently request that the fsmonitor listener thread shutdown.
+ * It does not wait for it to stop.  The caller should do a JOIN
+ * to wait for it.
+ */
+void fsm_listen__stop_async(struct fsmonitor_daemon_state *state);
+
+#endif /* HAVE_FSMONITOR_DAEMON_BACKEND */
+#endif /* FSM_LISTEN_H */
diff --git a/config.mak.uname b/config.mak.uname
index c48db45106c..9c88e1b244e 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -434,6 +434,11 @@ ifeq ($(uname_S),Windows)
 	# so we don't need this:
 	#
 	#   SNPRINTF_RETURNS_BOGUS = YesPlease
+
+	# The builtin FSMonitor requires Named Pipes and Threads on Windows.
+	# These are always available, so we do not have to conditionally
+	# support it.
+	FSMONITOR_DAEMON_BACKEND = win32
 	NO_SVN_TESTS = YesPlease
 	RUNTIME_PREFIX = YesPlease
 	HAVE_WPGMPTR = YesWeDo
@@ -619,6 +624,11 @@ ifeq ($(uname_S),MINGW)
 	NO_STRTOUMAX = YesPlease
 	NO_MKDTEMP = YesPlease
 	NO_SVN_TESTS = YesPlease
+
+	# The builtin FSMonitor requires Named Pipes and Threads on Windows.
+	# These are always available, so we do not have to conditionally
+	# support it.
+	FSMONITOR_DAEMON_BACKEND = win32
 	RUNTIME_PREFIX = YesPlease
 	HAVE_WPGMPTR = YesWeDo
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 5100f56bb37..1525a81109c 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -285,6 +285,13 @@ else()
 	endif()
 endif()
 
+if(SUPPORTS_SIMPLE_IPC)
+	if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
+		add_compile_definitions(HAVE_FSMONITOR_DAEMON_BACKEND)
+		list(APPEND compat_SOURCES compat/fsmonitor/fsm-listen-win32.c)
+	endif()
+endif()
+
 set(EXE_EXTENSION ${CMAKE_EXECUTABLE_SUFFIX})
 
 #header checks
diff --git a/repo-settings.c b/repo-settings.c
index 00ca5571a1a..373a341ad2b 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -2,6 +2,7 @@
 #include "config.h"
 #include "repository.h"
 #include "midx.h"
+#include "compat/fsmonitor/fsm-listen.h"
 
 static void repo_cfg_bool(struct repository *r, const char *key, int *dest,
 			  int def)
-- 
gitgitgadget

