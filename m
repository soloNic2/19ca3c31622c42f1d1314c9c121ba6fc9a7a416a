Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98478C433EF
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 13:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbiGRN3x (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 09:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbiGRN3u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 09:29:50 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB8862FB
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 06:29:45 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so7328742wmb.5
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 06:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M/gPwoaJvB4ssiaKk+eXfds43JjO9a6Rjv/bxCZmoMI=;
        b=BD3IVpSIyPpTtbdAVhsNk3oXBZNgMaLZUyovJEKvE7pOb1L5OtOZ3JewiPvlPGQpEq
         nx1Z+qhxApQW3ug9AZgCcvTIf7Wg8j7uzRqPH0BNynxm5DIWa6IXb/5AkNizwJSSdS46
         V4CzcOwtJedTghd6wMvZLKtkpQaB+36SELq8q303/XWb5b5aNHYcaq3nO4k6PJCbfmq6
         eJvhjUC1U1cWNgg8fvhQBKKjCvImxAWMXSIDpK4V6JFZ6bj/2myZKlDXHX06EeXyYN4w
         ioFdgWPCojKdml54R+R+qm3dPm4Cr3Y268P5RcfuqK7UVi7LibN0RG/FnpGnnqxs4zWc
         CRxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M/gPwoaJvB4ssiaKk+eXfds43JjO9a6Rjv/bxCZmoMI=;
        b=dJaRe+KpQMv/oeEb65s0PItwqjQBOySbulm7tEjXwdC965EPWwZbL7+/ae3MG7MWMv
         V4X7h3conksOf3G/ChWvRNaEWmNdtW9UHxneWICSJbgB8LLfFa0nc1JARCLk/yPPwvx4
         FYizXnECjP2tPTuAM0IoWFiSvZyiJq51cOxkzJia3R17zb1HGdGc9K+sXdskvyz96MIT
         klmwcQzKGRg9GSm0GMs02FmpWed+ho7YrUgFrJH9W6VbxLTpHO/c0okJGahMskJhkekJ
         grq5WHPqXLyOwbK3EDybBAEfxkj0cTU7iJ2khkb29xhpYuV+dfeokPq/sGFWqx7L9HXn
         PpqA==
X-Gm-Message-State: AJIora+4VvYjS/sHCBnflT1bsHWUTWqvmOHIKZbpkdU7LTdVF/D6L8/Q
        U28+U+wJbis5SZnElgc/2uOyZpSRK9F1Ng==
X-Google-Smtp-Source: AGRyM1tlvxSREEiOUkjfeeF1miCdKWxg5hzJWNljVh6Q71n78aXcozoGCVkwiiQFyzsrLqKeyBvoWQ==
X-Received: by 2002:a05:600c:3542:b0:3a1:6855:1153 with SMTP id i2-20020a05600c354200b003a168551153mr26751422wmq.121.1658150983355;
        Mon, 18 Jul 2022 06:29:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p4-20020a1c5444000000b003a30572072esm14277296wmi.6.2022.07.18.06.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 06:29:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Teng Long <dyroneteng@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 3/8] git docs: create a "Git file formats and protocols" section
Date:   Mon, 18 Jul 2022 15:29:29 +0200
Message-Id: <patch-v4-3.8-d196bcd1db0-20220718T132911Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1032.gb00b5447790
In-Reply-To: <cover-v4-0.8-00000000000-20220718T132911Z-avarab@gmail.com>
References: <cover-v3-0.7-00000000000-20220712T195419Z-avarab@gmail.com> <cover-v4-0.8-00000000000-20220718T132911Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a new "Git file formats and protocols" section in the main "git help
git" manual page and start moving the documentation that now lives in
"Documentation/technical/*.git" over to it. This compliments the newly
added and adjacent "User-facing file formats" section.

This makes the technical documentation more accessible and
discoverable. Before this we wouldn't install it by default, and had
no ability to build man page versions of them. The links to them from
our existing documentation link to the generated HTML version of these
docs.

So let's start moving those over, starting with just the
"bundle-format.txt" documentation added in 7378ec90e1c (doc: describe
Git bundle format, 2020-02-07). We'll now have a new
gitformat-bundle(5) man page. Subsequent commits will move more git
internal format documentation over.

Unfortunately the syntax of the current Documentation/technical/*.txt
is not the same (when it comes to section headings etc.) as our
Documentation/*.txt documentation, so change the relevant bits of
syntax as we're moving this over.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/Makefile                        |  3 +-
 Documentation/git-bundle.txt                  | 12 +++--
 Documentation/git-help.txt                    |  1 +
 Documentation/git.txt                         |  8 ++++
 ...bundle-format.txt => gitformat-bundle.txt} | 44 ++++++++++++++++---
 Documentation/lint-man-section-order.perl     |  3 ++
 builtin/help.c                                |  8 ++++
 command-list.txt                              |  5 +++
 help.c                                        | 12 +++++
 help.h                                        |  1 +
 t/t0012-help.sh                               |  2 +
 11 files changed, 87 insertions(+), 12 deletions(-)
 rename Documentation/{technical/bundle-format.txt => gitformat-bundle.txt} (79%)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 08b896a3c4c..404139274e7 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -24,6 +24,7 @@ MAN1_TXT += gitweb.txt
 
 # man5 / man7 guides (note: new guides should also be added to command-list.txt)
 MAN5_TXT += gitattributes.txt
+MAN5_TXT += gitformat-bundle.txt
 MAN5_TXT += githooks.txt
 MAN5_TXT += gitignore.txt
 MAN5_TXT += gitmailmap.txt
@@ -95,7 +96,6 @@ TECH_DOCS += MyFirstObjectWalk
 TECH_DOCS += SubmittingPatches
 TECH_DOCS += ToolsForGit
 TECH_DOCS += technical/bitmap-format
-TECH_DOCS += technical/bundle-format
 TECH_DOCS += technical/cruft-packs
 TECH_DOCS += technical/hash-function-transition
 TECH_DOCS += technical/http-protocol
@@ -291,6 +291,7 @@ cmds_txt = cmds-ancillaryinterrogators.txt \
 	cmds-synchelpers.txt \
 	cmds-guide.txt \
 	cmds-userformats.txt \
+	cmds-gitformats.txt \
 	cmds-purehelpers.txt \
 	cmds-foreignscminterface.txt
 
diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 7685b570455..1aeae09f082 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -56,10 +56,9 @@ using "thin packs", bundles created using exclusions are smaller in
 size. That they're "thin" under the hood is merely noted here as a
 curiosity, and as a reference to other documentation.
 
-See link:technical/bundle-format.html[the `bundle-format`
-documentation] for more details and the discussion of "thin pack" in
-link:technical/pack-format.html[the pack format documentation] for
-further details.
+See linkgit:gitformat-bundle[5] for more details and the discussion of
+"thin pack" in link:technical/pack-format.html[the pack format
+documentation] for further details.
 
 OPTIONS
 -------
@@ -337,6 +336,11 @@ You can also see what references it offers:
 $ git ls-remote mybundle
 ----------------
 
+FILE FORMAT
+-----------
+
+See linkgit:gitformat-bundle[5].
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 6c285709040..a91126ba802 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -13,6 +13,7 @@ SYNOPSIS
 'git help' [-g|--guides]
 'git help' [-c|--config]
 'git help' [--user-formats]
+'git help' [--git-formats]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 9b03bbc3851..1980a0e29cd 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -347,6 +347,14 @@ edit. These can also be listed with 'git help --user-formats'.
 
 include::cmds-userformats.txt[]
 
+Git file formats and protocols
+------------------------------
+
+This documentation discusses the file formats and protocols that git
+itself uses. These can also be listed with 'git help --git-formats'.
+
+include::cmds-gitformats.txt[]
+
 Configuration Mechanism
 -----------------------
 
diff --git a/Documentation/technical/bundle-format.txt b/Documentation/gitformat-bundle.txt
similarity index 79%
rename from Documentation/technical/bundle-format.txt
rename to Documentation/gitformat-bundle.txt
index b9be8644cf5..6a9d9e5bf6f 100644
--- a/Documentation/technical/bundle-format.txt
+++ b/Documentation/gitformat-bundle.txt
@@ -1,11 +1,33 @@
-= Git bundle v2 format
+gitformat-bundle(5)
+===================
 
-The Git bundle format is a format that represents both refs and Git objects.
+NAME
+----
+gitformat-bundle - The bundle file format
+
+
+SYNOPSIS
+--------
+[verse]
+*.bundle
+*.bdl
+
+DESCRIPTION
+-----------
+
+The Git bundle format is a format that represents both refs and Git
+objects. A bundle is a header in a format similar to
+linkgit:git-show-ref[1] followed by a pack in *.pack format.
 
-== Format
+The format is created and read by the linkgit:git-bundle[1] command,
+and supported by e.g. linkgit:git-fetch[1] and linkgit:git-clone[1].
+
+
+FORMAT
+------
 
 We will use ABNF notation to define the Git bundle format. See
-protocol-common.txt for the details.
+link:technical/protocol-common.html for the details.
 
 A v2 bundle looks like this:
 
@@ -36,7 +58,9 @@ value        = *(%01-09 / %0b-FF)
 pack         = ... ; packfile
 ----
 
-== Semantics
+
+SEMANTICS
+---------
 
 A Git bundle consists of several parts.
 
@@ -62,13 +86,15 @@ In the bundle format, there can be a comment following a prerequisite obj-id.
 This is a comment and it has no specific meaning. The writer of the bundle MAY
 put any string here. The reader of the bundle MUST ignore the comment.
 
-=== Note on the shallow clone and a Git bundle
+Note on the shallow clone and a Git bundle
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Note that the prerequisites does not represent a shallow-clone boundary. The
 semantics of the prerequisites and the shallow-clone boundaries are different,
 and the Git bundle v2 format cannot represent a shallow clone repository.
 
-== Capabilities
+CAPABILITIES
+------------
 
 Because there is no opportunity for negotiation, unknown capabilities cause 'git
 bundle' to abort.
@@ -79,3 +105,7 @@ bundle' to abort.
 * `filter` specifies an object filter as in the `--filter` option in
   linkgit:git-rev-list[1]. The resulting pack-file must be marked as a
   `.promisor` pack-file after it is unbundled.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/lint-man-section-order.perl b/Documentation/lint-man-section-order.perl
index 425377dfeb7..02408a0062f 100755
--- a/Documentation/lint-man-section-order.perl
+++ b/Documentation/lint-man-section-order.perl
@@ -32,6 +32,9 @@
 		'SEE ALSO' => {
 			order => $order++,
 		},
+		'FILE FORMAT' => {
+			order => $order++,
+		},
 		'GIT' => {
 			required => 1,
 			order => $order++,
diff --git a/builtin/help.c b/builtin/help.c
index b0164b774c2..3ff2c5d17a7 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -44,6 +44,7 @@ static enum help_action {
 	HELP_ACTION_GUIDES,
 	HELP_ACTION_CONFIG,
 	HELP_ACTION_USER_FORMATS,
+	HELP_ACTION_GIT_FORMATS,
 	HELP_ACTION_CONFIG_FOR_COMPLETION,
 	HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION,
 } cmd_mode;
@@ -72,6 +73,8 @@ static struct option builtin_help_options[] = {
 		    HELP_ACTION_GUIDES),
 	OPT_CMDMODE(0, "user-formats", &cmd_mode, N_("print list of user-facing file formats"),
 		    HELP_ACTION_USER_FORMATS),
+	OPT_CMDMODE(0, "git-formats", &cmd_mode, N_("print list of internal file formats and network protocols"),
+		    HELP_ACTION_GIT_FORMATS),
 	OPT_CMDMODE('c', "config", &cmd_mode, N_("print all configuration variable names"),
 		    HELP_ACTION_CONFIG),
 	OPT_CMDMODE_F(0, "config-for-completion", &cmd_mode, "",
@@ -88,6 +91,7 @@ static const char * const builtin_help_usage[] = {
 	"git help [-g|--guides]",
 	"git help [-c|--config]",
 	"git help [--user-formats]",
+	"git help [--git-formats]",
 	NULL
 };
 
@@ -662,6 +666,10 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 		opt_mode_usage(argc, "--user-formats", help_format);
 		list_user_formats_help();
 		return 0;
+	case HELP_ACTION_GIT_FORMATS:
+		opt_mode_usage(argc, "--git-formats", help_format);
+		list_git_formats_help();
+		return 0;
 	case HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION:
 		opt_mode_usage(argc, "--config-sections-for-completion",
 			       help_format);
diff --git a/command-list.txt b/command-list.txt
index c1eace8f7ad..1794a7279bc 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -47,6 +47,10 @@
 # .mailmap etc. files lives in man section 5. These entries can only
 # have the "userformats" attribute and nothing else.
 #
+# Git internal file formats and protocols, such as documentation for the
+# *.bundle format lives in man section 5. These entries can only have
+# the "gitformats" attribute and nothing else.
+#
 ### command list (do not change this line)
 # command name                          category [category] [category]
 git-add                                 mainporcelain           worktree
@@ -204,6 +208,7 @@ gitcvs-migration                        guide
 gitdiffcore                             guide
 giteveryday                             guide
 gitfaq                                  guide
+gitformat-bundle                        gitformats
 gitglossary                             guide
 githooks                                userformats
 gitignore                               userformats
diff --git a/help.c b/help.c
index 17ba210cf4e..68b1dc70aff 100644
--- a/help.c
+++ b/help.c
@@ -39,6 +39,7 @@ static struct category_description main_categories[] = {
 	{ CAT_synchingrepositories, N_("Low-level Commands / Syncing Repositories") },
 	{ CAT_purehelpers, N_("Low-level Commands / Internal Helpers") },
 	{ CAT_userformats, N_("Git user-facing file formats") },
+	{ CAT_gitformats, N_("Git internal file formats and protocols") },
 	{ 0, NULL }
 };
 
@@ -52,6 +53,7 @@ static const char *drop_prefix(const char *name, uint32_t category)
 	{
 	case CAT_guide:
 	case CAT_userformats:
+	case CAT_gitformats:
 		if (!skip_prefix(name, "git", &new_name))
 			BUG("category #%d but no 'git' prefix?", category);
 		return new_name;
@@ -442,6 +444,16 @@ void list_user_formats_help(void)
 	putchar('\n');
 }
 
+void list_git_formats_help(void)
+{
+	struct category_description catdesc[] = {
+		{ CAT_gitformats, N_("Internal file formats and protocols:") },
+		{ 0, NULL }
+	};
+	print_cmd_by_category(catdesc, NULL);
+	putchar('\n');
+}
+
 static int get_alias(const char *var, const char *value, void *data)
 {
 	struct string_list *list = data;
diff --git a/help.h b/help.h
index d8b744178ec..173bd890ce3 100644
--- a/help.h
+++ b/help.h
@@ -23,6 +23,7 @@ void list_common_cmds_help(void);
 void list_all_cmds_help(int show_external_commands, int show_aliases);
 void list_guides_help(void);
 void list_user_formats_help(void);
+void list_git_formats_help(void);
 
 void list_all_main_cmds(struct string_list *list);
 void list_all_other_cmds(struct string_list *list);
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index 91b5318aa32..0e291cb91e8 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -230,6 +230,8 @@ test_expect_success "'git help -a' section spacing" '
 	Low-level Commands / Internal Helpers
 
 	Git user-facing file formats
+
+	Git internal file formats and protocols
 	EOF
 	test_cmp expect actual
 '
-- 
2.37.1.1032.gb00b5447790

