Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50686C05027
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 15:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjAWPWs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 10:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjAWPW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 10:22:27 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48A828D0B
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 07:22:02 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d2so11132918wrp.8
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 07:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3nruLYI83rK7a0+moEicZfo/x6SocdUj6R2o/a4eOLg=;
        b=n2Aw1aWV5oavQ0bd7vzD9AFcmH5RdyHgKrhV8w7MgCXqgTbqJJzUVv66wmJGoTmeJu
         eKtKYYePnios6WqhpAoEskrHILR2o4bddaVPUIORU4dh+1Ftd+VCYbB/ZWTYIxV+uEZL
         0YwzcZSmOpr0V9dLQEnXSdFY2s8Xwa/tXA4nKcL5p9nk3Ms1diqoN97sHIAJzp4YI4ch
         vYWYOSFYs9YrbQmq7LjxF1J3qz5uzVUW2vsjveExkTytTvZ0+zIhkP6iPs8NYNQrh2VO
         JVTudzdmRLohKIpZZEr1AjVurhdvaOyRNTqPnj9SULYY43o1t+pElvIOzCqKMKh7ZzDX
         CvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3nruLYI83rK7a0+moEicZfo/x6SocdUj6R2o/a4eOLg=;
        b=7uTfF0w7EARhC0B1eIDwMJewvJHrys1SQZqnelKDws90aa4DtpPHFCZpYdemY0rL7x
         8WK8H/6SiKd17NYZRgWOl+fTOuqso0HArkOHAlnOwmJ1dmKb44sY1T/st3ai9yg+v3DO
         u2kM71kVHvgzCN+wHI6qF6Wdt7SZwfsgjv5fOWmIv8Ryl4zwBRu0zDgKdt/wzkY/Rcy5
         49/gi9CZK0bZ0lTQpnYPDdiA3w1/GuGfrchGemF/hQiSG5gvE+4CNw7RFCOQA+JlmCX8
         sa8JTMVG1TQ44re9GewC0ypmvilNfcoogCAK3gukcD7ObU1rNVd4P71Xn3KEPUyGyruQ
         Pj0A==
X-Gm-Message-State: AFqh2kpXc4wreWiLY/pQwXZoQ2m5z6xOT6eu7VwfMsU7+WWLWhDhnDxT
        zDp+8yLX68mChQ7mGybZ3mdM2/uebfg=
X-Google-Smtp-Source: AMrXdXtOkiLPsIq87qFmYxJR7XEzzpCa46JaP4OBpj5XL8bM4CQztGkgzdd3WCaUTV/PTKJNvx0+dw==
X-Received: by 2002:a05:6000:1290:b0:2b6:8a41:a949 with SMTP id f16-20020a056000129000b002b68a41a949mr21003892wrx.46.1674487315080;
        Mon, 23 Jan 2023 07:21:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u8-20020adfdd48000000b00241fab5a296sm4623690wrm.40.2023.01.23.07.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 07:21:54 -0800 (PST)
Message-Id: <f6f8197c9cc86a7b3b986953e4722b7c05241eba.1674487310.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
        <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 Jan 2023 15:21:43 +0000
Subject: [PATCH v2 03/10] bundle-uri: parse bundle.heuristic=creationToken
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        avarab@gmail.com, steadmon@google.com, chooglen@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The bundle.heuristic value communicates that the bundle list is
organized to make use of the bundle.<id>.creationToken values that may
be provided in the bundle list. Those values will create a total order
on the bundles, allowing the Git client to download them in a specific
order and even remember previously-downloaded bundles by storing the
maximum creation token value.

Before implementing any logic that parses or uses the
bundle.<id>.creationToken values, teach Git to parse the
bundle.heuristic value from a bundle list. We can use 'test-tool
bundle-uri' to print the heuristic value and verify that the parsing
works correctly.

As an extra precaution, create the internal 'heuristics' array to be a
list of (enum, string) pairs so we can iterate through the array entries
carefully, regardless of the enum values.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/config/bundle.txt |  7 +++++++
 bundle-uri.c                    | 34 +++++++++++++++++++++++++++++++++
 bundle-uri.h                    | 14 ++++++++++++++
 t/t5750-bundle-uri-parse.sh     | 19 ++++++++++++++++++
 4 files changed, 74 insertions(+)

diff --git a/Documentation/config/bundle.txt b/Documentation/config/bundle.txt
index daa21eb674a..3faae386853 100644
--- a/Documentation/config/bundle.txt
+++ b/Documentation/config/bundle.txt
@@ -15,6 +15,13 @@ bundle.mode::
 	complete understanding of the bundled information (`all`) or if any one
 	of the listed bundle URIs is sufficient (`any`).
 
+bundle.heuristic::
+	If this string-valued key exists, then the bundle list is designed to
+	work well with incremental `git fetch` commands. The heuristic signals
+	that there are additional keys available for each bundle that help
+	determine which subset of bundles the client should download. The
+	only value currently understood is `creationToken`.
+
 bundle.<id>.*::
 	The `bundle.<id>.*` keys are used to describe a single item in the
 	bundle list, grouped under `<id>` for identification purposes.
diff --git a/bundle-uri.c b/bundle-uri.c
index 2f079f713cf..0d64b1d84ba 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -9,6 +9,14 @@
 #include "config.h"
 #include "remote.h"
 
+static struct {
+	enum bundle_list_heuristic heuristic;
+	const char *name;
+} heuristics[BUNDLE_HEURISTIC__COUNT] = {
+	{ BUNDLE_HEURISTIC_NONE, ""},
+	{ BUNDLE_HEURISTIC_CREATIONTOKEN, "creationToken" },
+};
+
 static int compare_bundles(const void *hashmap_cmp_fn_data,
 			   const struct hashmap_entry *he1,
 			   const struct hashmap_entry *he2,
@@ -100,6 +108,17 @@ void print_bundle_list(FILE *fp, struct bundle_list *list)
 	fprintf(fp, "\tversion = %d\n", list->version);
 	fprintf(fp, "\tmode = %s\n", mode);
 
+	if (list->heuristic) {
+		int i;
+		for (i = 0; i < BUNDLE_HEURISTIC__COUNT; i++) {
+			if (heuristics[i].heuristic == list->heuristic) {
+				printf("\theuristic = %s\n",
+				       heuristics[list->heuristic].name);
+				break;
+			}
+		}
+	}
+
 	for_all_bundles_in_list(list, summarize_bundle, fp);
 }
 
@@ -142,6 +161,21 @@ static int bundle_list_update(const char *key, const char *value,
 			return 0;
 		}
 
+		if (!strcmp(subkey, "heuristic")) {
+			int i;
+			for (i = 0; i < BUNDLE_HEURISTIC__COUNT; i++) {
+				if (heuristics[i].heuristic &&
+				    heuristics[i].name &&
+				    !strcmp(value, heuristics[i].name)) {
+					list->heuristic = heuristics[i].heuristic;
+					return 0;
+				}
+			}
+
+			/* Ignore unknown heuristics. */
+			return 0;
+		}
+
 		/* Ignore other unknown global keys. */
 		return 0;
 	}
diff --git a/bundle-uri.h b/bundle-uri.h
index d5e89f1671c..2e44a50a90b 100644
--- a/bundle-uri.h
+++ b/bundle-uri.h
@@ -52,6 +52,14 @@ enum bundle_list_mode {
 	BUNDLE_MODE_ANY
 };
 
+enum bundle_list_heuristic {
+	BUNDLE_HEURISTIC_NONE = 0,
+	BUNDLE_HEURISTIC_CREATIONTOKEN,
+
+	/* Must be last. */
+	BUNDLE_HEURISTIC__COUNT
+};
+
 /**
  * A bundle_list contains an unordered set of remote_bundle_info structs,
  * as well as information about the bundle listing, such as version and
@@ -75,6 +83,12 @@ struct bundle_list {
 	 * advertised by the bundle list at that location.
 	 */
 	char *baseURI;
+
+	/**
+	 * A list can have a heuristic, which helps reduce the number of
+	 * downloaded bundles.
+	 */
+	enum bundle_list_heuristic heuristic;
 };
 
 void init_bundle_list(struct bundle_list *list);
diff --git a/t/t5750-bundle-uri-parse.sh b/t/t5750-bundle-uri-parse.sh
index 7b4f930e532..6fc92a9c0d4 100755
--- a/t/t5750-bundle-uri-parse.sh
+++ b/t/t5750-bundle-uri-parse.sh
@@ -250,4 +250,23 @@ test_expect_success 'parse config format edge cases: empty key or value' '
 	test_cmp_config_output expect actual
 '
 
+test_expect_success 'parse config format: creationToken heuristic' '
+	cat >expect <<-\EOF &&
+	[bundle]
+		version = 1
+		mode = all
+		heuristic = creationToken
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
 test_done
-- 
gitgitgadget

