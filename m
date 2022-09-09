Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E0BECAAD3
	for <git@archiver.kernel.org>; Fri,  9 Sep 2022 14:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbiIIOeR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Sep 2022 10:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbiIIOdt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2022 10:33:49 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274C070E4B
        for <git@vger.kernel.org>; Fri,  9 Sep 2022 07:33:48 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id n12so3068764wru.6
        for <git@vger.kernel.org>; Fri, 09 Sep 2022 07:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=QCqqG8TLVSaUa3UDxn5Wa/bnuk48jJ5S4hqAcItvZu4=;
        b=Y9rNY+1asRuxt/NebC1spKjPqzpWlmgYj1Q2vFhFunv2hpD4OmjgcbSB9JsMlj0tpw
         R1gjq7shb6BNPvs+OKQFaMBS9wcsB/deXDTZpRnmhqEm6Buuav4fut3s1o/wbzbW6gGl
         HsbR/2d8xh7B/syaN9n63TTI2J15ogGH5xyQOvpHOuIsF9N7dfB13x6+6uCl4ILoOaxm
         rb0SVnZAombskoH7IxQ0+hh58sItwInpstMqLFdnRjOfFnju9u9yP6lJ5QCP1W1hfJ85
         KyLVcsEPIUElDUrD+grflBdlQvXNIs1bKYOeH43T/IUYymN8Nd8ysrZWnmy1QbN9Frov
         0iXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=QCqqG8TLVSaUa3UDxn5Wa/bnuk48jJ5S4hqAcItvZu4=;
        b=tKlZ2PFgrKjOTpWlNeh05X3jVK3qHdHcOjCovQhWE+9kNuW8GbLenylo+VQaBafx6U
         tGUGhh0Cr+ZpuD8ZEogiDjvHYF4Yo1HwbhxSrNGT7J1zjI51OJhIxx8nCGIwxBJ+KLZm
         9E49PbKeohe5npGb3AVZH+ZU7m2nUEG6Sn0THydWwNTVsk5cFsERjaOGY/s1nIdq7ocK
         tJy45BvPc35pzuhIrny7yBRL+MBEMrF+oTF2qBTe+oja4tj6vHDu2WC2MV5ulI+uKaU7
         6TuXvxox7Pg9vJy1QOWGdNf03rHEF4vQQyxmpP8Q9p7uwQXjqyrWRv9zfvo8td5Jx9jE
         GckQ==
X-Gm-Message-State: ACgBeo35b4usL5bhPh43DVG7k1fNTEi07LHq3amMGB1gL97jLo5QV5Xn
        XRgGFW6SaugpH9LK0GudtTO62Nl2H4I=
X-Google-Smtp-Source: AA6agR4NGaDiX9zO0LCfpjxg/D5pnUJFQAF2eG9CDlwWKUUMi3RExljP0Cgk3Styn5WQobvcd9c76g==
X-Received: by 2002:adf:db90:0:b0:226:cecd:d10b with SMTP id u16-20020adfdb90000000b00226cecdd10bmr8275617wri.531.1662734026274;
        Fri, 09 Sep 2022 07:33:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l20-20020a05600c4f1400b003a607e395ebsm1376207wmq.9.2022.09.09.07.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 07:33:45 -0700 (PDT)
Message-Id: <1492b8f5ef031f30374a626b4f6e772427531e23.1662734015.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1333.v2.git.1662734015.gitgitgadget@gmail.com>
References: <pull.1333.git.1661181174.gitgitgadget@gmail.com>
        <pull.1333.v2.git.1662734015.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 09 Sep 2022 14:33:33 +0000
Subject: [PATCH v2 7/9] bundle-uri: parse bundle list in config format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Teng Long <dyroneteng@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

When a bundle provider wants to operate independently from a Git remote,
they want to provide a single, consistent URI that users can use in
their 'git clone --bundle-uri' commands. At this point, the Git client
expects that URI to be a single bundle that can be unbundled and used to
bootstrap the rest of the clone from the Git server. This single bundle
cannot be re-used to assist with future incremental fetches.

To allow for the incremental fetch case, teach Git to understand a
bundle list that could be advertised at an independent bundle URI. Such
a bundle list is likely to be inspected by human readers, even if only
by the bundle provider creating the list. For this reason, we can take
our expected "key=value" pairs and instead format them using Git config
format.

Create bundle_uri_parse_config_format() to parse a file in config format
and convert that into a 'struct bundle_list' filled with its
understanding of the contents.

Be careful to use error_action CONFIG_ERROR_ERROR when calling
git_config_from_file_with_options() because the default action for
git_config_from_file() is to die() on a parsing error.  The current
warning isn't particularly helpful if it arises to a user, but it will
be made more verbose at a higher layer later.

Update 'test-tool bundle-uri' to take this config file format as input.
It uses a filename instead of stdin because there is no existing way to
parse a FILE pointer in the config machinery. Using
git_config_from_mem() is overly complicated and more likely to introduce
bugs than this simpler version.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle-uri.c                | 27 ++++++++++++++++++++
 bundle-uri.h                |  9 +++++++
 t/helper/test-bundle-uri.c  | 49 +++++++++++++++++++++++++++---------
 t/t5750-bundle-uri-parse.sh | 50 +++++++++++++++++++++++++++++++++++++
 4 files changed, 123 insertions(+), 12 deletions(-)

diff --git a/bundle-uri.c b/bundle-uri.c
index 74d5695e99e..92354aa3bbd 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -173,6 +173,33 @@ static int bundle_list_update(const char *key, const char *value,
 	return 0;
 }
 
+static int config_to_bundle_list(const char *key, const char *value, void *data)
+{
+	struct bundle_list *list = data;
+	return bundle_list_update(key, value, list);
+}
+
+int bundle_uri_parse_config_format(const char *uri,
+				   const char *filename,
+				   struct bundle_list *list)
+{
+	int result;
+	struct config_options opts = {
+		.error_action = CONFIG_ERROR_ERROR,
+	};
+
+	result = git_config_from_file_with_options(config_to_bundle_list,
+						   filename, list,
+						   &opts);
+
+	if (!result && list->mode == BUNDLE_MODE_NONE) {
+		warning(_("bundle list at '%s' has no mode"), uri);
+		result = 1;
+	}
+
+	return result;
+}
+
 static char *find_temp_filename(void)
 {
 	int fd;
diff --git a/bundle-uri.h b/bundle-uri.h
index 0e56ab2ae5a..bc13d4c9929 100644
--- a/bundle-uri.h
+++ b/bundle-uri.h
@@ -62,6 +62,15 @@ int for_all_bundles_in_list(struct bundle_list *list,
 struct FILE;
 void print_bundle_list(FILE *fp, struct bundle_list *list);
 
+/**
+ * A bundle URI may point to a bundle list where the key=value
+ * pairs are provided in config file format. This method is
+ * exposed publicly for testing purposes.
+ */
+int bundle_uri_parse_config_format(const char *uri,
+				   const char *filename,
+				   struct bundle_list *list);
+
 /**
  * Fetch data from the given 'uri' and unbundle the bundle data found
  * based on that information.
diff --git a/t/helper/test-bundle-uri.c b/t/helper/test-bundle-uri.c
index 0329c56544f..25afd393428 100644
--- a/t/helper/test-bundle-uri.c
+++ b/t/helper/test-bundle-uri.c
@@ -4,12 +4,21 @@
 #include "strbuf.h"
 #include "string-list.h"
 
-static int cmd__bundle_uri_parse(int argc, const char **argv)
+enum input_mode {
+	KEY_VALUE_PAIRS,
+	CONFIG_FILE,
+};
+
+static int cmd__bundle_uri_parse(int argc, const char **argv, enum input_mode mode)
 {
 	const char *key_value_usage[] = {
 		"test-tool bundle-uri parse-key-values <input>",
 		NULL
 	};
+	const char *config_usage[] = {
+		"test-tool bundle-uri parse-config <input>",
+		NULL
+	};
 	const char **usage = key_value_usage;
 	struct option options[] = {
 		OPT_END(),
@@ -19,21 +28,35 @@ static int cmd__bundle_uri_parse(int argc, const char **argv)
 	int err = 0;
 	FILE *fp;
 
-	argc = parse_options(argc, argv, NULL, options, usage, 0);
-	if (argc != 1)
-		goto usage;
+	if (mode == CONFIG_FILE)
+		usage = config_usage;
+
+	argc = parse_options(argc, argv, NULL, options, usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
 
 	init_bundle_list(&list);
-	fp = fopen(argv[0], "r");
-	if (!fp)
-		die("failed to open '%s'", argv[0]);
 
-	while (strbuf_getline(&sb, fp) != EOF) {
-		if (bundle_uri_parse_line(&list, sb.buf))
-			err = error("bad line: '%s'", sb.buf);
+	switch (mode) {
+	case KEY_VALUE_PAIRS:
+		if (argc != 1)
+			goto usage;
+		fp = fopen(argv[0], "r");
+		if (!fp)
+			die("failed to open '%s'", argv[0]);
+		while (strbuf_getline(&sb, fp) != EOF) {
+			if (bundle_uri_parse_line(&list, sb.buf))
+				err = error("bad line: '%s'", sb.buf);
+		}
+		fclose(fp);
+		break;
+
+	case CONFIG_FILE:
+		if (argc != 1)
+			goto usage;
+		err = bundle_uri_parse_config_format("<uri>", argv[0], &list);
+		break;
 	}
 	strbuf_release(&sb);
-	fclose(fp);
 
 	print_bundle_list(stdout, &list);
 
@@ -62,7 +85,9 @@ int cmd__bundle_uri(int argc, const char **argv)
 		goto usage;
 
 	if (!strcmp(argv[1], "parse-key-values"))
-		return cmd__bundle_uri_parse(argc - 1, argv + 1);
+		return cmd__bundle_uri_parse(argc - 1, argv + 1, KEY_VALUE_PAIRS);
+	if (!strcmp(argv[1], "parse-config"))
+		return cmd__bundle_uri_parse(argc - 1, argv + 1, CONFIG_FILE);
 	error("there is no test-tool bundle-uri tool '%s'", argv[1]);
 
 usage:
diff --git a/t/t5750-bundle-uri-parse.sh b/t/t5750-bundle-uri-parse.sh
index fd142a66ad5..c2fe3f9c5a5 100755
--- a/t/t5750-bundle-uri-parse.sh
+++ b/t/t5750-bundle-uri-parse.sh
@@ -118,4 +118,54 @@ test_expect_success 'bundle_uri_parse_line() parsing edge cases: duplicate lines
 	test_cmp_config_output expect actual
 '
 
+test_expect_success 'parse config format: just URIs' '
+	cat >expect <<-\EOF &&
+	[bundle]
+		version = 1
+		mode = all
+	[bundle "one"]
+		uri = http://example.com/bundle.bdl
+	[bundle "two"]
+		uri = https://example.com/bundle.bdl
+	[bundle "three"]
+		uri = file:///usr/share/git/bundle.bdl
+	EOF
+
+	test-tool bundle-uri parse-config expect >actual 2>err &&
+	test_must_be_empty err &&
+	test_cmp_config_output expect actual
+'
+
+test_expect_success 'parse config format edge cases: empty key or value' '
+	cat >in1 <<-\EOF &&
+	= bogus-value
+	EOF
+
+	cat >err1 <<-EOF &&
+	error: bad config line 1 in file in1
+	EOF
+
+	cat >expect <<-\EOF &&
+	[bundle]
+		version = 1
+		mode = all
+	EOF
+
+	test_must_fail test-tool bundle-uri parse-config in1 >actual 2>err &&
+	test_cmp err1 err &&
+	test_cmp_config_output expect actual &&
+
+	cat >in2 <<-\EOF &&
+	bogus-key =
+	EOF
+
+	cat >err2 <<-EOF &&
+	error: bad config line 1 in file in2
+	EOF
+
+	test_must_fail test-tool bundle-uri parse-config in2 >actual 2>err &&
+	test_cmp err2 err &&
+	test_cmp_config_output expect actual
+'
+
 test_done
-- 
gitgitgadget

