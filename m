Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC90C4167B
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 21:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbiLLVgf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 16:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiLLVga (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 16:36:30 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03D525E9
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 13:36:28 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id w15so13622867wrl.9
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 13:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUdy5+lwLcyYzmn69jjG1A8V0jJQApX5scNAQaOGLjY=;
        b=pa5i9iaG64OE3IG2iZ0abwlhMBWk2YVuc3Mbufr32/2s5lT1Px9S9FMl0cOnjHnlcs
         R3v355CnYpT9rPZ9jPyxuXojGgvvQdQFRjo8TodupT9q+NzZJFX6k/Myf636MSVglNYt
         SIzhdKr2G3tEKoCYPHPxhZqCD8ji//u9HkQbbHGRuDk9D/kq9RUaTZnNt8E+OnIHbjwm
         2qBcr7ZCdaEzWb2TBvrRB1FjYFEgNgA6VC0zblu6e2wuYXkCeM5uFRTJFh3QVI8VY0vp
         d+0FEcndpN2RSImWg0M84ZQ02har7FYVvoTrJYxzeiftaHkjzKkjhb6JdmhB79RJM52n
         Nwkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MUdy5+lwLcyYzmn69jjG1A8V0jJQApX5scNAQaOGLjY=;
        b=C/e54plf2X4hY5x/FzdihF1Ucrowo5Bbd9pGcavySpJgmk9s1stsx2zBb8VkFT6193
         bx/zhSNMq5Md2Nj4sw1m6sfQ2S8XjBVX1WYUORjDQfqOgYdRyPZ/49rfofYJ8lJSKgIc
         Ab6aXcSJqR+7RhyM8jHSiZ3wfnMz7Es9zhq/EPkF6GY/xEGjiYcWTK0ru7Hg/Xtm/aBU
         m6T1tJ5axgdzpOwYAqAE1gwU7yV2ek8TpM+M+LUcn//wIfIHpjx4NcramYLqe6N8ASGH
         wrhfG517LZ1Be9LrzYr+RSlWbX+trNLDS9iMQzXOTjExpcux76o/EAJ3CbTJknRjsEfe
         nTBw==
X-Gm-Message-State: ANoB5pmfa1ygki8yknBvEAC3thsK0Fce/x/PlKApqeadCM+r4vx16/A7
        BOhVC0/D2Qf4qeBzVH3haMN34HmynMQ=
X-Google-Smtp-Source: AA0mqf7mffJxlKsPk+9K0cgkXhU3Ho46qojpJGpLQrzVnX+0xgpdtz8kbO5UyLof++s2lf5xsPqfoA==
X-Received: by 2002:a5d:4892:0:b0:241:6654:62f1 with SMTP id g18-20020a5d4892000000b00241665462f1mr9846410wrq.49.1670880987186;
        Mon, 12 Dec 2022 13:36:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x1-20020a5d4441000000b0023677081f3asm9762912wrr.42.2022.12.12.13.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 13:36:26 -0800 (PST)
Message-Id: <b5b56ccd9419353a4bf5bc9d751a711af07d2197.1670880984.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>
References: <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com>
        <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>
From:   "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Dec 2022 21:36:16 +0000
Subject: [PATCH v4 1/8] http: read HTTP WWW-Authenticate response headers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Matthew John Cheetham <mjcheetham@github.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew John Cheetham <mjcheetham@outlook.com>

Read and store the HTTP WWW-Authenticate response headers made for
a particular request.

This will allow us to pass important authentication challenge
information to credential helpers or others that would otherwise have
been lost.

According to RFC2616 Section 4.2 [1], header field names are not
case-sensitive meaning when collecting multiple values for the same
field name, we can just use the case of the first observed instance of
each field name and no normalisation is required.

libcurl only provides us with the ability to read all headers recieved
for a particular request, including any intermediate redirect requests
or proxies. The lines returned by libcurl include HTTP status lines
delinating any intermediate requests such as "HTTP/1.1 200". We use
these lines to reset the strvec of WWW-Authenticate header values as
we encounter them in order to only capture the final response headers.

The collection of all header values matching the WWW-Authenticate
header is complicated by the fact that it is legal for header fields to
be continued over multiple lines, but libcurl only gives us one line at
a time.

In the future [2] we may be able to leverage functions to read headers
from libcurl itself, but as of today we must do this ourselves.

[1] https://datatracker.ietf.org/doc/html/rfc2616#section-4.2
[2] https://daniel.haxx.se/blog/2022/03/22/a-headers-api-for-libcurl/

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 credential.c |  1 +
 credential.h | 15 ++++++++++
 http.c       | 78 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 94 insertions(+)

diff --git a/credential.c b/credential.c
index f6389a50684..897b4679333 100644
--- a/credential.c
+++ b/credential.c
@@ -22,6 +22,7 @@ void credential_clear(struct credential *c)
 	free(c->username);
 	free(c->password);
 	string_list_clear(&c->helpers, 0);
+	strvec_clear(&c->wwwauth_headers);
 
 	credential_init(c);
 }
diff --git a/credential.h b/credential.h
index f430e77fea4..6f2e5bc610b 100644
--- a/credential.h
+++ b/credential.h
@@ -2,6 +2,7 @@
 #define CREDENTIAL_H
 
 #include "string-list.h"
+#include "strvec.h"
 
 /**
  * The credentials API provides an abstracted way of gathering username and
@@ -115,6 +116,19 @@ struct credential {
 	 */
 	struct string_list helpers;
 
+	/**
+	 * A `strvec` of WWW-Authenticate header values. Each string
+	 * is the value of a WWW-Authenticate header in an HTTP response,
+	 * in the order they were received in the response.
+	 */
+	struct strvec wwwauth_headers;
+
+	/**
+	 * Internal use only. Used to keep track of split header fields
+	 * in order to fold multiple lines into one value.
+	 */
+	unsigned header_is_last_match:1;
+
 	unsigned approved:1,
 		 configured:1,
 		 quit:1,
@@ -130,6 +144,7 @@ struct credential {
 
 #define CREDENTIAL_INIT { \
 	.helpers = STRING_LIST_INIT_DUP, \
+	.wwwauth_headers = STRVEC_INIT, \
 }
 
 /* Initialize a credential structure, setting all fields to empty. */
diff --git a/http.c b/http.c
index 8a5ba3f4776..c4e9cd73e14 100644
--- a/http.c
+++ b/http.c
@@ -183,6 +183,82 @@ size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
 	return nmemb;
 }
 
+static size_t fwrite_wwwauth(char *ptr, size_t eltsize, size_t nmemb, void *p)
+{
+	size_t size = eltsize * nmemb;
+	struct strvec *values = &http_auth.wwwauth_headers;
+	struct strbuf buf = STRBUF_INIT;
+	const char *val;
+	const char *z = NULL;
+
+	/*
+	 * Header lines may not come NULL-terminated from libcurl so we must
+	 * limit all scans to the maximum length of the header line, or leverage
+	 * strbufs for all operations.
+	 *
+	 * In addition, it is possible that header values can be split over
+	 * multiple lines as per RFC 2616 (even though this has since been
+	 * deprecated in RFC 7230). A continuation header field value is
+	 * identified as starting with a space or horizontal tab.
+	 *
+	 * The formal definition of a header field as given in RFC 2616 is:
+	 *
+	 *   message-header = field-name ":" [ field-value ]
+	 *   field-name     = token
+	 *   field-value    = *( field-content | LWS )
+	 *   field-content  = <the OCTETs making up the field-value
+	 *                    and consisting of either *TEXT or combinations
+	 *                    of token, separators, and quoted-string>
+	 */
+
+	strbuf_add(&buf, ptr, size);
+
+	/* Strip the CRLF that should be present at the end of each field */
+	strbuf_trim_trailing_newline(&buf);
+
+	/* Start of a new WWW-Authenticate header */
+	if (skip_iprefix(buf.buf, "www-authenticate:", &val)) {
+		while (isspace(*val))
+			val++;
+
+		strvec_push(values, val);
+		http_auth.header_is_last_match = 1;
+		goto exit;
+	}
+
+	/*
+	 * This line could be a continuation of the previously matched header
+	 * field. If this is the case then we should append this value to the
+	 * end of the previously consumed value.
+	 */
+	if (http_auth.header_is_last_match && isspace(*buf.buf)) {
+		const char **v = values->v + values->nr - 1;
+		char *append = xstrfmt("%s%.*s", *v, (int)(size - 1), ptr + 1);
+
+		free((void*)*v);
+		*v = append;
+
+		goto exit;
+	}
+
+	/* This is the start of a new header we don't care about */
+	http_auth.header_is_last_match = 0;
+
+	/*
+	 * If this is a HTTP status line and not a header field, this signals
+	 * a different HTTP response. libcurl writes all the output of all
+	 * response headers of all responses, including redirects.
+	 * We only care about the last HTTP request response's headers so clear
+	 * the existing array.
+	 */
+	if (skip_iprefix(buf.buf, "http/", &z))
+		strvec_clear(values);
+
+exit:
+	strbuf_release(&buf);
+	return size;
+}
+
 size_t fwrite_null(char *ptr, size_t eltsize, size_t nmemb, void *strbuf)
 {
 	return nmemb;
@@ -1864,6 +1940,8 @@ static int http_request(const char *url,
 					 fwrite_buffer);
 	}
 
+	curl_easy_setopt(slot->curl, CURLOPT_HEADERFUNCTION, fwrite_wwwauth);
+
 	accept_language = http_get_accept_language_header();
 
 	if (accept_language)
-- 
gitgitgadget

