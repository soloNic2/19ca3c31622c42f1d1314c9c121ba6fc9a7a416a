Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243BEC43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 16:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbiGUQPg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 12:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232853AbiGUQPG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 12:15:06 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544978AB23
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 09:14:48 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so3663942wme.0
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 09:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b2W9p3mPrLJZuSbR6DQ1sI21a5s4grW8y45OFH2QynA=;
        b=bBo9bwuXWZZsHpIOLkUs/daiVmsmFPr6xFjlVtDDYBoPevUFUIhlbr4hfPgcOhVFea
         1AqKbZGKYuYK15YLJTZaqUsfdTW1Hq+OpNYjuMZxVhYM1AP2GWhuJpj8Xgd5qKV6xylb
         Bqs+Xrg4FHPkkZK0tC38/OP4CI5dDRwzBN7WwBcnHjTM/wg2KTre/nNZqB5tmky55rBn
         EcsOWdNgmrfkRDz6No6QNLkHKC60fS1tJEBcgJVIwAygMyUGfb+/R+seLNTCchHa327C
         SVWrrSoUXhS0czL44+SzJBVWWj/RKTqL/Ty5UYzc3+b0OwLR9HHSM5MIZWqqP2O9dmA8
         9TuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b2W9p3mPrLJZuSbR6DQ1sI21a5s4grW8y45OFH2QynA=;
        b=0PRw+5mJ4FzBeTteglpS+BOHqgN45fuxqJemB8vai4BzisUewYxoIl77nBZ5vbtHS1
         Pp5m67sAuLLP/J0j01rzqegvV1VvHWBzH5KMauVhAaZzUAYY3UOjlDa9u79uwGAoH8A4
         tqRNPZ6zOA9UyLICjFlSF1vC/U3PV1RIc5SWSO3360uU8+QHqAeQmaw316hL8xc+GHpY
         MNs8THNttjxbF3U701Z27B5uVTNjmuqrDLkf72rQIIAgpizOEPOVkg+L7PSHaD3H3Sog
         k93lh4vkdnUd7/J9EZKu5CRagcx9lowutlWdb/Zs9C1hxcS7wreFGiNqydoiI8zJ4W6C
         6dAg==
X-Gm-Message-State: AJIora9fWfBDREcEv3VTrhQwdCxK3GztAUBUxNPSRHrX30u/is5eaM0p
        9geB5mmuTw7qci6A3HXLoGjXv9LMFhwA+A==
X-Google-Smtp-Source: AGRyM1vi+MJL6Fi6/KaFtS8G6vH46DIaBcnv+l2vD3z+OFvR0a6KvWrsvu/44nZYkDd0BOIPaxSG/w==
X-Received: by 2002:a05:600c:3593:b0:3a3:3a49:41a3 with SMTP id p19-20020a05600c359300b003a33a4941a3mr769323wmq.166.1658420060866;
        Thu, 21 Jul 2022 09:14:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n21-20020a05600c4f9500b003a2f2bb72d5sm8498608wmq.45.2022.07.21.09.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 09:14:19 -0700 (PDT)
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
Subject: [PATCH v5 4/9] git docs: add a category for file formats, protocols and interfaces
Date:   Thu, 21 Jul 2022 18:13:53 +0200
Message-Id: <patch-v5-4.9-a7310898866-20220721T160721Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1095.g64a1e8362fd
In-Reply-To: <cover-v5-0.9-00000000000-20220721T160721Z-avarab@gmail.com>
References: <cover-v4-0.8-00000000000-20220718T132911Z-avarab@gmail.com> <cover-v5-0.9-00000000000-20220721T160721Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a new "File formats, protocols and other developer interfaces"
section in the main "git help git" manual page and start moving the
documentation that now lives in "Documentation/technical/*.git" over
to it. This compliments the newly added and adjacent "Repository,
command and file interfaces" section.

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
 Documentation/git-bundle.txt                  | 14 +++---
 Documentation/git-help.txt                    |  5 +++
 Documentation/git.txt                         |  9 ++++
 ...bundle-format.txt => gitformat-bundle.txt} | 44 ++++++++++++++++---
 Documentation/lint-man-section-order.perl     |  3 ++
 builtin/help.c                                |  9 ++++
 command-list.txt                              |  5 +++
 help.c                                        | 12 +++++
 help.h                                        |  1 +
 t/t0012-help.sh                               |  2 +
 11 files changed, 94 insertions(+), 13 deletions(-)
 rename Documentation/{technical/bundle-format.txt => gitformat-bundle.txt} (79%)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 28eb940a9b8..1a4a545f44a 100644
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
@@ -290,6 +290,7 @@ cmds_txt = cmds-ancillaryinterrogators.txt \
 	cmds-synchingrepositories.txt \
 	cmds-synchelpers.txt \
 	cmds-guide.txt \
+	cmds-developerinterfaces.txt \
 	cmds-userinterfaces.txt \
 	cmds-purehelpers.txt \
 	cmds-foreignscminterface.txt
diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 7685b570455..f0b1282b918 100644
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
@@ -77,7 +76,7 @@ verify <file>::
 	commits exist and are fully linked in the current repository.
 	Then, 'git bundle' prints a list of missing commits, if any.
 	Finally, information about additional capabilities, such as "object
-	filter", is printed. See "Capabilities" in link:technical/bundle-format.html
+	filter", is printed. See "Capabilities" in linkgit:gitformat-bundle[5]
 	for more information. The exit code is zero for success, but will
 	be nonzero if the bundle file is invalid.
 
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
index 4eb03bd6c38..2b0b5e390dc 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -13,6 +13,7 @@ SYNOPSIS
 'git help' [-g|--guides]
 'git help' [-c|--config]
 'git help' [--user-interfaces]
+'git help' [--developer-interfaces]
 
 DESCRIPTION
 -----------
@@ -83,6 +84,10 @@ user-interface conventions (e.g. linkgit:gitcli[7]), and
 pseudo-configuration such as the file-based `.git/hooks/*` interface
 described in linkgit:githooks[5].
 
+--developer-interfaces::
+	Print list of file formats, protocols and other developer
+	interfaces documentation on the standard output.
+
 -i::
 --info::
 	Display manual page for the command in the 'info' format. The
diff --git a/Documentation/git.txt b/Documentation/git.txt
index f69d32e1e79..f064951b5c4 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -348,6 +348,15 @@ linkgit:git-help[1] for more details on the critera.
 
 include::cmds-userinterfaces.txt[]
 
+File formats, protocols and other developer interfaces
+------------------------------------------------------
+
+This documentation discusses file formats, over-the-wire protocols and
+other git developer interfaces. See `--developer-interfaces` in
+linkgit:git-help[1].
+
+include::cmds-developerinterfaces.txt[]
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
index 1ab1c8a0dd7..09ac4289f13 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -44,6 +44,7 @@ static enum help_action {
 	HELP_ACTION_GUIDES,
 	HELP_ACTION_CONFIG,
 	HELP_ACTION_USER_INTERFACES,
+	HELP_ACTION_DEVELOPER_INTERFACES,
 	HELP_ACTION_CONFIG_FOR_COMPLETION,
 	HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION,
 } cmd_mode;
@@ -73,6 +74,9 @@ static struct option builtin_help_options[] = {
 	OPT_CMDMODE(0, "user-interfaces", &cmd_mode,
 		    N_("print list of user-facing repository, command and file interfaces"),
 		    HELP_ACTION_USER_INTERFACES),
+	OPT_CMDMODE(0, "developer-interfaces", &cmd_mode,
+		    N_("print list of file formats, protocols and other developer interfaces"),
+		    HELP_ACTION_DEVELOPER_INTERFACES),
 	OPT_CMDMODE('c', "config", &cmd_mode, N_("print all configuration variable names"),
 		    HELP_ACTION_CONFIG),
 	OPT_CMDMODE_F(0, "config-for-completion", &cmd_mode, "",
@@ -89,6 +93,7 @@ static const char * const builtin_help_usage[] = {
 	"git help [-g|--guides]",
 	"git help [-c|--config]",
 	"git help [--user-interfaces]",
+	"git help [--developer-interfaces]",
 	NULL
 };
 
@@ -663,6 +668,10 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 		opt_mode_usage(argc, "--user-interfaces", help_format);
 		list_user_interfaces_help();
 		return 0;
+	case HELP_ACTION_DEVELOPER_INTERFACES:
+		opt_mode_usage(argc, "--developer-interfaces", help_format);
+		list_developer_interfaces_help();
+		return 0;
 	case HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION:
 		opt_mode_usage(argc, "--config-sections-for-completion",
 			       help_format);
diff --git a/command-list.txt b/command-list.txt
index 1d45303e14c..1950c4ccd9c 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -48,6 +48,10 @@
 # sections 5 and 7. These entries can only have the "userinterfaces"
 # attribute and nothing else.
 #
+# Git's file formats and protocols, such as documentation for the
+# *.bundle format lives in man section 5. These entries can only have
+# the "developerinterfaces" attribute and nothing else.
+#
 ### command list (do not change this line)
 # command name                          category [category] [category]
 git-add                                 mainporcelain           worktree
@@ -205,6 +209,7 @@ gitcvs-migration                        guide
 gitdiffcore                             guide
 giteveryday                             guide
 gitfaq                                  guide
+gitformat-bundle                        developerinterfaces
 gitglossary                             guide
 githooks                                userinterfaces
 gitignore                               userinterfaces
diff --git a/help.c b/help.c
index a2ceda1723d..71f1c905d1c 100644
--- a/help.c
+++ b/help.c
@@ -39,6 +39,7 @@ static struct category_description main_categories[] = {
 	{ CAT_synchingrepositories, N_("Low-level Commands / Syncing Repositories") },
 	{ CAT_purehelpers, N_("Low-level Commands / Internal Helpers") },
 	{ CAT_userinterfaces, N_("User-facing repository, command and file interfaces") },
+	{ CAT_developerinterfaces, N_("Developer-facing file file formats, protocols and interfaces") },
 	{ 0, NULL }
 };
 
@@ -52,6 +53,7 @@ static const char *drop_prefix(const char *name, uint32_t category)
 	switch (category) {
 	case CAT_guide:
 	case CAT_userinterfaces:
+	case CAT_developerinterfaces:
 		prefix = "git";
 		if (!skip_prefix(name, prefix, &new_name))
 			BUG("'%s' in category #%d should have '%s' prefix",
@@ -444,6 +446,16 @@ void list_user_interfaces_help(void)
 	putchar('\n');
 }
 
+void list_developer_interfaces_help(void)
+{
+	struct category_description catdesc[] = {
+		{ CAT_developerinterfaces, N_("File formats, protocols and other developer interfaces:") },
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
index 243104c27a7..af073a7a026 100644
--- a/help.h
+++ b/help.h
@@ -23,6 +23,7 @@ void list_common_cmds_help(void);
 void list_all_cmds_help(int show_external_commands, int show_aliases);
 void list_guides_help(void);
 void list_user_interfaces_help(void);
+void list_developer_interfaces_help(void);
 
 void list_all_main_cmds(struct string_list *list);
 void list_all_other_cmds(struct string_list *list);
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index bee5ed12203..4ed2f242eb2 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -230,6 +230,8 @@ test_expect_success "'git help -a' section spacing" '
 	Low-level Commands / Internal Helpers
 
 	User-facing repository, command and file interfaces
+
+	Developer-facing file file formats, protocols and interfaces
 	EOF
 	test_cmp expect actual
 '
-- 
2.37.1.1095.g64a1e8362fd

