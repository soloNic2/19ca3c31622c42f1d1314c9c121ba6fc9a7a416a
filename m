Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C882C43334
	for <git@archiver.kernel.org>; Sat, 23 Jul 2022 06:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235848AbiGWGox (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jul 2022 02:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiGWGov (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jul 2022 02:44:51 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53C664E15
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 23:44:49 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id a18-20020a05600c349200b003a30de68697so5835542wmq.0
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 23:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3R8hz3SsnnkRnfLraeW0wCo8u3w+4hg1ENVOdd8QYQ8=;
        b=hPjwDyI9aa8hk9lFgI9U4HZnJ3PVjFggsVqYeJgbPqzA5DD5tYkQk8qBVZPbc8aevJ
         Q0hgNo5Lm4gK88EVY51cbctGxl0CDn0fftq/v5H58217TVS+v4Hk21DwMtnqBPc201RF
         PyfgSg1t4Gk/aZRLedL3ZIfliZpTRtK7DdMC2uXLc9Cvt7lcGtXoBTB8ggj9zpLmYQHY
         L9DUn0WqMa7sgBkJtjWcpIsUjYRp/nx9vqqqzHBBU8E7fr6bCVJH1Pj9V7olDIcAHzNe
         wGZInKkr/azOPdfjq7pN9cH1lfcRoR4/8d114Qo3rxditLsGTsoPnBnk2yWx37gpNa1V
         N2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3R8hz3SsnnkRnfLraeW0wCo8u3w+4hg1ENVOdd8QYQ8=;
        b=fk3allNPV+VmZWor9cjTevoIiX7mek9cb1fVdb1x7uAYyIVoZBpAVpTbZ1TcmT/nmM
         eos6/GxCFmCphs03LBQyDTdiUITQdp7gJ/YrVphuVWP2yhErtt0DUENpuChGbXtVplbx
         AxHYp9h/uAgh8Bv75OGLQW3TF0vP25vWOGD1yyxlIHHDCg10JzSlcoh8LbTU5Gz0WyuN
         UkQajysuIwXVzIf80tbm9A/J0uZK3KOqPFIXUTjqRhLFKdtPk59SaZ3M+Dn979V0CZVu
         zONOmfJrfwGNoFNhir5y0YUkEcOnj76yGuxXb9Q934cBoWuT3a6D54TkrGyRsHbfzThM
         kULw==
X-Gm-Message-State: AJIora/+o1cYIx+aqgdhLmtEYvjzTItNR2bkTXLv7R6foU/H9e90LH+u
        ZNeZNaJYFmmSXIr80wCZF3R9/mluIVI=
X-Google-Smtp-Source: AGRyM1vxTsThkKHpByQUmNd4dIkYK3Elug5hCq+3qEYpPqN9Chj1cekjpiaUxNTsNAVSuI2crrZYNg==
X-Received: by 2002:a05:600c:1908:b0:3a3:f85:702a with SMTP id j8-20020a05600c190800b003a30f85702amr15216691wmq.157.1658558687952;
        Fri, 22 Jul 2022 23:44:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q13-20020adff78d000000b0021d69860b66sm7487656wrp.9.2022.07.22.23.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 23:44:46 -0700 (PDT)
Message-Id: <pull.1262.v9.git.1658558685407.gitgitgadget@gmail.com>
In-Reply-To: <pull.1262.v8.git.1658334983053.gitgitgadget@gmail.com>
References: <pull.1262.v8.git.1658334983053.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 23 Jul 2022 06:44:45 +0000
Subject: [PATCH v9] ls-files: introduce "--format" option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Add a new option "--format" that outputs index entries
informations in a custom format, taking inspiration
from the option with the same name in the `git ls-tree`
command.

"--format" cannot used with "-s", "-o", "-k", "-t",
" --resolve-undo","--deduplicate" and "--eol".

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    ls-files: introduce "--format" options
    
    v7->v8:
    
     1. wrap the usage with _() and fix grammar error.
     2. fix test case title.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1262%2Fadlternative%2Fzh%2Fls-file-format-v9
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1262/adlternative/zh/ls-file-format-v9
Pull-Request: https://github.com/gitgitgadget/git/pull/1262

Range-diff vs v8:

 1:  e765ee28e90 ! 1:  df602d30bf4 ls-files: introduce "--format" option
     @@ builtin/ls-files.c: int cmd_ls_files(int argc, const char **argv, const char *cm
      +
      +	if (format && (show_stage || show_others || show_killed ||
      +		show_resolve_undo || skipping_duplicates || show_eol || show_tag))
     -+			usage_msg_opt("--format cannot used with -s, -o, -k, -t, "
     -+				      "--resolve-undo, --deduplicate, --eol",
     ++			usage_msg_opt(_("--format cannot be used with -s, -o, -k, -t, "
     ++				      "--resolve-undo, --deduplicate, --eol"),
      +				      ls_files_usage, builtin_ls_files_options);
      +
       	if (show_tag || show_valid_bit || show_fsmonitor_bit) {
     @@ t/t3013-ls-files-format.sh (new)
      +	printf "LINEONE\nLINETWO\nLINETHREE\n" >o1.txt &&
      +	printf "LINEONE\r\nLINETWO\r\nLINETHREE\r\n" >o2.txt &&
      +	printf "LINEONE\r\nLINETWO\nLINETHREE\n" >o3.txt &&
     -+	git add . &&
     ++	git add o?.txt &&
      +	oid=$(git hash-object o1.txt) &&
      +	git update-index --add --cacheinfo 120000 $oid o4.txt &&
      +	git update-index --add --cacheinfo 160000 $oid o5.txt &&
     @@ t/t3013-ls-files-format.sh (new)
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'git ls-files --format imitate --stage' '
     ++test_expect_success 'git ls-files --format v.s -s' '
      +	git ls-files --stage >expect &&
      +	git ls-files --format="%(objectmode) %(objectname) %(stage)%x09%(path)" >actual &&
      +	test_cmp expect actual


 Documentation/git-ls-files.txt | 39 +++++++++++++-
 builtin/ls-files.c             | 95 ++++++++++++++++++++++++++++++++++
 t/t3013-ls-files-format.sh     | 95 ++++++++++++++++++++++++++++++++++
 3 files changed, 228 insertions(+), 1 deletion(-)
 create mode 100755 t/t3013-ls-files-format.sh

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 0dabf3f0ddc..d7986419c25 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -20,7 +20,7 @@ SYNOPSIS
 		[--exclude-standard]
 		[--error-unmatch] [--with-tree=<tree-ish>]
 		[--full-name] [--recurse-submodules]
-		[--abbrev[=<n>]] [--] [<file>...]
+		[--abbrev[=<n>]] [--format=<format>] [--] [<file>...]
 
 DESCRIPTION
 -----------
@@ -192,6 +192,13 @@ followed by the  ("attr/<eolattr>").
 	to the contained files. Sparse directories will be shown with a
 	trailing slash, such as "x/" for a sparse directory "x".
 
+--format=<format>::
+	A string that interpolates `%(fieldname)` from the result being shown.
+	It also interpolates `%%` to `%`, and `%xx` where `xx` are hex digits
+	interpolates to character with hex code `xx`; for example `%00`
+	interpolates to `\0` (NUL), `%09` to `\t` (TAB) and %0a to `\n` (LF).
+	--format cannot be combined with `-s`, `-o`, `-k`, `-t`, `--resolve-undo`
+	and `--eol`.
 \--::
 	Do not interpret any more arguments as options.
 
@@ -223,6 +230,36 @@ quoted as explained for the configuration variable `core.quotePath`
 (see linkgit:git-config[1]).  Using `-z` the filename is output
 verbatim and the line is terminated by a NUL byte.
 
+It is possible to print in a custom format by using the `--format`
+option, which is able to interpolate different fields using
+a `%(fieldname)` notation. For example, if you only care about the
+"objectname" and "path" fields, you can execute with a specific
+"--format" like
+
+	git ls-files --format='%(objectname) %(path)'
+
+FIELD NAMES
+-----------
+The way each path is shown can be customized by using the
+`--format=<format>` option, where the %(fieldname) in the
+<format> string for various aspects of the index entry are
+interpolated.  The following "fieldname" are understood:
+
+objectmode::
+	The mode of the file which is recorded in the index.
+objectname::
+	The name of the file which is recorded in the index.
+stage::
+	The stage of the file which is recorded in the index.
+eolinfo:index::
+eolinfo:worktree::
+	The <eolinfo> (see the description of the `--eol` option) of
+	the contents in the index or in the worktree for the path.
+eolattr::
+	The <eolattr> (see the description of the `--eol` option)
+	that applies to the path.
+path::
+	The pathname of the file which is recorded in the index.
 
 EXCLUDE PATTERNS
 ----------------
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index e791b65e7e9..779dc18e59d 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -11,6 +11,7 @@
 #include "quote.h"
 #include "dir.h"
 #include "builtin.h"
+#include "strbuf.h"
 #include "tree.h"
 #include "cache-tree.h"
 #include "parse-options.h"
@@ -48,6 +49,7 @@ static char *ps_matched;
 static const char *with_tree;
 static int exc_given;
 static int exclude_args;
+static const char *format;
 
 static const char *tag_cached = "";
 static const char *tag_unmerged = "";
@@ -85,6 +87,16 @@ static void write_name(const char *name)
 				   stdout, line_terminator);
 }
 
+static void write_name_to_buf(struct strbuf *sb, const char *name)
+{
+	const char *rel = relative_path(name, prefix_len ? prefix : NULL, sb);
+
+	if (line_terminator)
+		quote_c_style(rel, sb, NULL, 0);
+	else
+		strbuf_addstr(sb, rel);
+}
+
 static const char *get_tag(const struct cache_entry *ce, const char *tag)
 {
 	static char alttag[4];
@@ -222,6 +234,73 @@ static void show_submodule(struct repository *superproject,
 	repo_clear(&subrepo);
 }
 
+struct show_index_data {
+	const char *pathname;
+	struct index_state *istate;
+	const struct cache_entry *ce;
+};
+
+static size_t expand_show_index(struct strbuf *sb, const char *start,
+				void *context)
+{
+	struct show_index_data *data = context;
+	const char *end;
+	const char *p;
+	size_t len = strbuf_expand_literal_cb(sb, start, NULL);
+	struct stat st;
+
+	if (len)
+		return len;
+	if (*start != '(')
+		die(_("bad ls-files format: element '%s' "
+		      "does not start with '('"), start);
+
+	end = strchr(start + 1, ')');
+	if (!end)
+		die(_("bad ls-files format: element '%s'"
+		      "does not end in ')'"), start);
+
+	len = end - start + 1;
+	if (skip_prefix(start, "(objectmode)", &p))
+		strbuf_addf(sb, "%06o", data->ce->ce_mode);
+	else if (skip_prefix(start, "(objectname)", &p))
+		strbuf_add_unique_abbrev(sb, &data->ce->oid, abbrev);
+	else if (skip_prefix(start, "(stage)", &p))
+		strbuf_addf(sb, "%d", ce_stage(data->ce));
+	else if (skip_prefix(start, "(eolinfo:index)", &p))
+		strbuf_addstr(sb, S_ISREG(data->ce->ce_mode) ?
+			      get_cached_convert_stats_ascii(data->istate,
+			      data->ce->name) : "");
+	else if (skip_prefix(start, "(eolinfo:worktree)", &p))
+		strbuf_addstr(sb, !lstat(data->pathname, &st) &&
+			      S_ISREG(st.st_mode) ?
+			      get_wt_convert_stats_ascii(data->pathname) : "");
+	else if (skip_prefix(start, "(eolattr)", &p))
+		strbuf_addstr(sb, get_convert_attr_ascii(data->istate,
+			      data->pathname));
+	else if (skip_prefix(start, "(path)", &p))
+		write_name_to_buf(sb, data->pathname);
+	else
+		die(_("bad ls-files format: %%%.*s"), (int)len, start);
+
+	return len;
+}
+
+static void show_ce_fmt(struct repository *repo, const struct cache_entry *ce,
+			const char *format, const char *fullname) {
+	struct show_index_data data = {
+		.pathname = fullname,
+		.istate = repo->index,
+		.ce = ce,
+	};
+	struct strbuf sb = STRBUF_INIT;
+
+	strbuf_expand(&sb, format, expand_show_index, &data);
+	strbuf_addch(&sb, line_terminator);
+	fwrite(sb.buf, sb.len, 1, stdout);
+	strbuf_release(&sb);
+}
+
 static void show_ce(struct repository *repo, struct dir_struct *dir,
 		    const struct cache_entry *ce, const char *fullname,
 		    const char *tag)
@@ -236,6 +315,12 @@ static void show_ce(struct repository *repo, struct dir_struct *dir,
 				  max_prefix_len, ps_matched,
 				  S_ISDIR(ce->ce_mode) ||
 				  S_ISGITLINK(ce->ce_mode))) {
+		if (format) {
+			show_ce_fmt(repo, ce, format, fullname);
+			print_debug(ce);
+			return;
+		}
+
 		tag = get_tag(ce, tag);
 
 		if (!show_stage) {
@@ -675,6 +760,9 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 			 N_("suppress duplicate entries")),
 		OPT_BOOL(0, "sparse", &show_sparse_dirs,
 			 N_("show sparse directories in the presence of a sparse index")),
+		OPT_STRING_F(0, "format", &format, N_("format"),
+			     N_("format to use for the output"),
+			     PARSE_OPT_NONEG),
 		OPT_END()
 	};
 	int ret = 0;
@@ -699,6 +787,13 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	for (i = 0; i < exclude_list.nr; i++) {
 		add_pattern(exclude_list.items[i].string, "", 0, pl, --exclude_args);
 	}
+
+	if (format && (show_stage || show_others || show_killed ||
+		show_resolve_undo || skipping_duplicates || show_eol || show_tag))
+			usage_msg_opt(_("--format cannot be used with -s, -o, -k, -t, "
+				      "--resolve-undo, --deduplicate, --eol"),
+				      ls_files_usage, builtin_ls_files_options);
+
 	if (show_tag || show_valid_bit || show_fsmonitor_bit) {
 		tag_cached = "H ";
 		tag_unmerged = "M ";
diff --git a/t/t3013-ls-files-format.sh b/t/t3013-ls-files-format.sh
new file mode 100755
index 00000000000..efb7450bf1e
--- /dev/null
+++ b/t/t3013-ls-files-format.sh
@@ -0,0 +1,95 @@
+#!/bin/sh
+
+test_description='git ls-files --format test'
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+
+for flag in -s -o -k -t --resolve-undo --deduplicate --eol
+do
+	test_expect_success "usage: --format is incompatible with $flag" '
+		test_expect_code 129 git ls-files --format="%(objectname)" $flag
+	'
+done
+
+test_expect_success 'setup' '
+	printf "LINEONE\nLINETWO\nLINETHREE\n" >o1.txt &&
+	printf "LINEONE\r\nLINETWO\r\nLINETHREE\r\n" >o2.txt &&
+	printf "LINEONE\r\nLINETWO\nLINETHREE\n" >o3.txt &&
+	git add o?.txt &&
+	oid=$(git hash-object o1.txt) &&
+	git update-index --add --cacheinfo 120000 $oid o4.txt &&
+	git update-index --add --cacheinfo 160000 $oid o5.txt &&
+	git update-index --add --cacheinfo 100755 $oid o6.txt &&
+	git commit -m base
+'
+
+test_expect_success 'git ls-files --format objectmode v.s. -s' '
+	git ls-files -s >files &&
+	cut -d" " -f1 files >expect &&
+	git ls-files --format="%(objectmode)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files --format objectname v.s. -s' '
+	git ls-files -s >files &&
+	cut -d" " -f2 files >expect &&
+	git ls-files --format="%(objectname)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files --format v.s. --eol' '
+	git ls-files --eol >tmp &&
+	sed -e "s/	/ /g" -e "s/  */ /g" tmp >expect 2>err &&
+	test_must_be_empty err &&
+	git ls-files --format="i/%(eolinfo:index) w/%(eolinfo:worktree) attr/%(eolattr) %(path)" >actual 2>err &&
+	test_must_be_empty err &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files --format path v.s. -s' '
+	git ls-files -s >files &&
+	cut -f2 files >expect &&
+	git ls-files --format="%(path)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files --format with -m' '
+	echo change >o1.txt &&
+	cat >expect <<-\EOF &&
+	o1.txt
+	o4.txt
+	o5.txt
+	o6.txt
+	EOF
+	git ls-files --format="%(path)" -m >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files --format with -d' '
+	echo o7 >o7.txt &&
+	git add o7.txt &&
+	rm o7.txt &&
+	cat >expect <<-\EOF &&
+	o4.txt
+	o5.txt
+	o6.txt
+	o7.txt
+	EOF
+	git ls-files --format="%(path)" -d >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files --format v.s -s' '
+	git ls-files --stage >expect &&
+	git ls-files --format="%(objectmode) %(objectname) %(stage)%x09%(path)" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git ls-files --format with --debug' '
+	git ls-files --debug >expect &&
+	git ls-files --format="%(path)" --debug >actual &&
+	test_cmp expect actual
+'
+
+test_done

base-commit: ab336e8f1c8009c8b1aab8deb592148e69217085
-- 
gitgitgadget
