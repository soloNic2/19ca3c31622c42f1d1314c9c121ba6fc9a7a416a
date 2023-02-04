Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F160C636D6
	for <git@archiver.kernel.org>; Sat,  4 Feb 2023 13:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbjBDNnp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Feb 2023 08:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbjBDNni (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2023 08:43:38 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D810221285
        for <git@vger.kernel.org>; Sat,  4 Feb 2023 05:43:36 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id u8so3138993ilq.13
        for <git@vger.kernel.org>; Sat, 04 Feb 2023 05:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2gJN58XYrIXV6frkqmIifi2QOO4FjIp8US0PDm+Bnc=;
        b=oi/SMhFcSz4VwaJKVgxcKNplnzjOxzFzzTDRFBphA8J0B6I4Y9mnoRObSlRG0iHh1W
         i/xdzeDD4gJT7dKSjtAGTIhq2cMJRZT7+8NxjON30O5m+lARWgYbsk2KHK+ErDULgP4u
         gXEEuisrBWcFL9n3SPZVed4s1y1AbgrLOPlckpLYH8YIdcl8PcJKC9rM58TBcfiAqzX0
         wxhbuvrJx5YYof6qKisDo/ohqeGvFnuvvXCvXpfC4OPMM6m26hYWOLZBDU3iMX0wFah5
         V1i6R+DrnIysMgw/Pdg92mDSNmNQP1MOsAXbl+MefLb4o+wO9Ye3LLzTyI3IVVVKw75e
         YLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O2gJN58XYrIXV6frkqmIifi2QOO4FjIp8US0PDm+Bnc=;
        b=1VcbsIT7w0+y8ws/A0FUHaSBPKKYPpBQ4WJ3DAWzgYr/8nKjQ7+6yRxHipeTVdlDNX
         U3VNDDQnOGfiiSBqsbqb2nQJ07s0krPBtNlrT5f5FI19Pdtxkzf66QvRNvUiXaHCE+mZ
         Ux75jo9tVGCd/SSvMie6G44dmScHFGi6TrsqBSgPgTyvvg4irvyVcxebvRriXKWj/HAA
         n5vvogpWRLfgyVQhq4lnAffJJ7Uw0GwUGR3nUcI/z9JJwZwvNQjMTOR0SJZNQVY8bzMa
         9yOTIVcmc/kDr4QU63x1G1JPrrIQ05mNSD+/LQqoDHEPN3XO1G6+UbtAfwwlsPdJiNSC
         y3yA==
X-Gm-Message-State: AO0yUKWLzSX/OwPlKyboZpkx/EwpOygUZmVmuxvH4o8MM/NecyxUJlBE
        qY1fuJP/PjOZsf4qqp7HqfY=
X-Google-Smtp-Source: AK7set+So/NA8M1L5KigAcRzke0N+VayHFZwpsiVx2wMHRAPrBs7i4MGKQOTFdd3OKDZRpq3NYDNSA==
X-Received: by 2002:a05:6e02:1549:b0:310:d05b:3a1 with SMTP id j9-20020a056e02154900b00310d05b03a1mr11581944ilu.20.1675518216056;
        Sat, 04 Feb 2023 05:43:36 -0800 (PST)
Received: from titov.fritz.box ([191.101.157.6])
        by smtp.gmail.com with ESMTPSA id q8-20020a027b08000000b003af4300d670sm1802449jac.27.2023.02.04.05.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 05:43:35 -0800 (PST)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     Tassilo Horn <tsdh@gnu.org>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Paolo Bonzini <pbonzini@redhat.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 1/3] userdiff: support Java type parameters
Date:   Sat,  4 Feb 2023 14:43:27 +0100
Message-Id: <20230204134329.251451-2-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230204134329.251451-1-rybak.a.v@gmail.com>
References: <877cwxvl3a.fsf@gnu.org>
 <20230204134329.251451-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A class or interface in Java [1] can have type parameters immediately
following the name in the declaration, surrounded by angle brackets
(paired less than and greater than signs).[2]  Example of a class with
type parameters "A" and "N":

    public class ParameterizedClass<A, N> {
        private A field1;
        private N field2;
    }

Support matching a parameterized class or interface declaration with
type parameters immediately following the name of the type in the
builtin userdiff pattern for Java.  Do so by just allowing matching the
first character after the name of the type to "<".

An alternative approach could be to match both the opening and the
closing angle brackets and matching the content between them in various
ways.  Just use the simpler regex for now.

[1] Since Java 5 released in 2004.
[2] Detailed description is available in the Java Language
    Specification, sections "Type Variables" and "Parameterized Types":
    https://docs.oracle.com/javase/specs/jls/se17/html/jls-4.html#jls-4.4

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t4018/java-class-type-parameters             | 6 ++++++
 t/t4018/java-class-type-parameters-implements  | 6 ++++++
 t/t4018/java-interface-type-parameters         | 6 ++++++
 t/t4018/java-interface-type-parameters-extends | 6 ++++++
 userdiff.c                                     | 2 +-
 5 files changed, 25 insertions(+), 1 deletion(-)
 create mode 100644 t/t4018/java-class-type-parameters
 create mode 100644 t/t4018/java-class-type-parameters-implements
 create mode 100644 t/t4018/java-interface-type-parameters
 create mode 100644 t/t4018/java-interface-type-parameters-extends

diff --git a/t/t4018/java-class-type-parameters b/t/t4018/java-class-type-parameters
new file mode 100644
index 0000000000..579aa7af21
--- /dev/null
+++ b/t/t4018/java-class-type-parameters
@@ -0,0 +1,6 @@
+class RIGHT<A, B> {
+    static int ONE;
+    static int TWO;
+    static int THREE;
+    private A ChangeMe;
+}
diff --git a/t/t4018/java-class-type-parameters-implements b/t/t4018/java-class-type-parameters-implements
new file mode 100644
index 0000000000..b8038b1866
--- /dev/null
+++ b/t/t4018/java-class-type-parameters-implements
@@ -0,0 +1,6 @@
+class RIGHT<A, B> implements List<A> {
+    static int ONE;
+    static int TWO;
+    static int THREE;
+    private A ChangeMe;
+}
diff --git a/t/t4018/java-interface-type-parameters b/t/t4018/java-interface-type-parameters
new file mode 100644
index 0000000000..a4baa1ae68
--- /dev/null
+++ b/t/t4018/java-interface-type-parameters
@@ -0,0 +1,6 @@
+interface RIGHT<A, B> {
+    static int ONE;
+    static int TWO;
+    static int THREE;
+    public B foo(A ChangeMe);
+}
diff --git a/t/t4018/java-interface-type-parameters-extends b/t/t4018/java-interface-type-parameters-extends
new file mode 100644
index 0000000000..31d7fb3244
--- /dev/null
+++ b/t/t4018/java-interface-type-parameters-extends
@@ -0,0 +1,6 @@
+interface RIGHT<A, B> extends Function<A, B> {
+    static int ONE;
+    static int TWO;
+    static int THREE;
+    public B foo(A ChangeMe);
+}
diff --git a/userdiff.c b/userdiff.c
index d71b82feb7..759e22ffff 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -171,7 +171,7 @@ PATTERNS("html",
 PATTERNS("java",
 	 "!^[ \t]*(catch|do|for|if|instanceof|new|return|switch|throw|while)\n"
 	 /* Class, enum, and interface declarations */
-	 "^[ \t]*(([a-z]+[ \t]+)*(class|enum|interface)[ \t]+[A-Za-z][A-Za-z0-9_$]*[ \t]+.*)$\n"
+	 "^[ \t]*(([a-z]+[ \t]+)*(class|enum|interface)[ \t]+[A-Za-z][A-Za-z0-9_$]*([ \t]+|<).*)$\n"
 	 /* Method definitions; note that constructor signatures are not */
 	 /* matched because they are indistinguishable from method calls. */
 	 "^[ \t]*(([A-Za-z_<>&][][?&<>.,A-Za-z_0-9]*[ \t]+)+[A-Za-z_][A-Za-z_0-9]*[ \t]*\\([^;]*)$",
-- 
2.39.1

