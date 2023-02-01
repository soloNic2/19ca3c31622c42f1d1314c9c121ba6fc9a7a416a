Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C38C05027
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 11:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjBALi3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 06:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbjBALi1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 06:38:27 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3471D92A
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 03:38:26 -0800 (PST)
Received: (qmail 31506 invoked by uid 109); 1 Feb 2023 11:38:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Feb 2023 11:38:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19341 invoked by uid 111); 1 Feb 2023 11:38:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Feb 2023 06:38:25 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 1 Feb 2023 06:38:24 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Todd Zullinger <tmz@pobox.com>
Subject: [PATCH 2/4] t/lib-httpd: bump required apache version to 2.4
Message-ID: <Y9pPML4wqui0BtXg@coredump.intra.peff.net>
References: <Y9pOmR5fOfCHwYpF@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y9pOmR5fOfCHwYpF@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apache 2.4 has been out since early 2012, almost 11 years. And its
predecessor, 2.2, has been out of support since its last release in
2017, over 5 years ago. The last mention on the mailing list was from
around the same time, in this thread:

  https://lore.kernel.org/git/20171231023234.21215-1-tmz@pobox.com/

We can probably assume that 2.4 is available everywhere. And the stakes
are fairly low, as the worst case is that such a platform would skip the
http tests.

This lets us clean up a few minor version checks in the config file, but
also revert f1f2b45be0 (tests: adjust the configuration for Apache 2.2,
2016-05-09). Its technique isn't _too_ bad, but certainly required a bit
more explanation than the 2.4 version it replaced. I manually confirmed
that the test in t5551 still behaves as expected (if you replace
"cadabra" with "foo", the server correctly rejects the request).

It will also help future patches which will no longer have to deal with
conditional config for this old version.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/lib-httpd.sh          |  4 ++--
 t/lib-httpd/apache.conf | 22 ++++------------------
 2 files changed, 6 insertions(+), 20 deletions(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 8fc411ff41..5d2d56c445 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -108,10 +108,10 @@ then
 	if test -z "$LIB_HTTPD_MODULE_PATH"
 	then
 		if ! test "$HTTPD_VERSION_MAJOR" -eq 2 ||
-		   ! test "$HTTPD_VERSION_MINOR" -ge 2
+		   ! test "$HTTPD_VERSION_MINOR" -ge 4
 		then
 			test_skip_or_die GIT_TEST_HTTPD \
-				"at least Apache version 2.2 is required"
+				"at least Apache version 2.4 is required"
 		fi
 		if ! test -d "$DEFAULT_HTTPD_MODULE_PATH"
 		then
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 35f5e28507..332617f10d 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -34,10 +34,6 @@ LoadModule http2_module modules/mod_http2.so
 Protocols h2c
 </IfDefine>
 
-<IfVersion < 2.4>
-LockFile accept.lock
-</IfVersion>
-
 <IfModule !mod_auth_basic.c>
 	LoadModule auth_basic_module modules/mod_auth_basic.so
 </IfModule>
@@ -51,7 +47,6 @@ LockFile accept.lock
 	LoadModule authz_host_module modules/mod_authz_host.so
 </IfModule>
 
-<IfVersion >= 2.4>
 <IfModule !mod_authn_core.c>
 	LoadModule authn_core_module modules/mod_authn_core.so
 </IfModule>
@@ -75,7 +70,6 @@ LockFile accept.lock
 	LoadModule mpm_prefork_module modules/mod_mpm_prefork.so
 </IfModule>
 </IfDefine>
-</IfVersion>
 
 PassEnv GIT_VALGRIND
 PassEnv GIT_VALGRIND_OPTIONS
@@ -115,6 +109,10 @@ Alias /auth/dumb/ www/auth/dumb/
 	Header set Set-Cookie name=value
 </LocationMatch>
 <LocationMatch /smart_headers/>
+	<RequireAll>
+		Require expr %{HTTP:x-magic-one} == 'abra'
+		Require expr %{HTTP:x-magic-two} == 'cadabra'
+	</RequireAll>
 	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
 	SetEnv GIT_HTTP_EXPORT_ALL
 </LocationMatch>
@@ -197,18 +195,6 @@ RewriteRule ^/intern-redir/(.*)/foo$ /smart/$1 [PT]
 RewriteRule ^/redir-objects/(.*/info/refs)$ /dumb/$1 [PT]
 RewriteRule ^/redir-objects/(.*/objects/.*)$ /dumb/$1 [R=301]
 
-# Apache 2.2 does not understand <RequireAll>, so we use RewriteCond.
-# And as RewriteCond does not allow testing for non-matches, we match
-# the desired case first (one has abra, two has cadabra), and let it
-# pass by marking the RewriteRule as [L], "last rule, do not process
-# any other matching RewriteRules after this"), and then have another
-# RewriteRule that matches all other cases and lets them fail via '[F]',
-# "fail the request".
-RewriteCond %{HTTP:x-magic-one} =abra
-RewriteCond %{HTTP:x-magic-two} =cadabra
-RewriteRule ^/smart_headers/.* - [L]
-RewriteRule ^/smart_headers/.* - [F]
-
 <IfDefine SSL>
 LoadModule ssl_module modules/mod_ssl.so
 
-- 
2.39.1.767.gb4615b3bd3

