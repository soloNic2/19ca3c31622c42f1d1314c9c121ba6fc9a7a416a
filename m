Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A32FC76196
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 15:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjDAPLd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 11:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjDAPK6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 11:10:58 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17851F7B2
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 08:10:54 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id s13so14564327wmr.4
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 08:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680361854;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+giBddeP/vAOtEknKR5vDnEexHLIbZoW933D35Ivkg=;
        b=OEbmzuYjZMdHed/W+ImnTRTnuU2s6df6BxgsdjzTQ0zxNBKUF3FcHw9LjwjJlqTjjk
         sLen+JU+96860guT+TgvhkAPVWuNOEzJClGZCTYNfzod4074oBavUdj+A4FSn6h88DJl
         YRSVJA+I7/UcIiz8kb4B4n2je2TdVna0yBDqLNlMxsI8VpCeETjNrXnT7z5Ne9N03Fpn
         mgOFBTNduii40lDfc0ghw8EBT2FfQ9Eayi9WebHgZOEAzshievbPke1FTMS6pKF2SoLy
         b3WTaj8C4+QNFv5ssf3pUSt1+txlBdanDHS1HBkuycMwCLDgzdTPn89UXnF4jNvUKvCk
         MKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680361854;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O+giBddeP/vAOtEknKR5vDnEexHLIbZoW933D35Ivkg=;
        b=EkKCxozYtJZRxRGKbA12JJecy1TmJeG2gZ1B7EOi5JmkS+pNKBeQpczvenJI14XOe9
         kC4cQIVtjfYNanT9h4REml/BvP0d+k6vh3d4+TEXuFeE8Na5sfWUYuDi2gQ88eFc16wg
         ix00j0jFYilP0Mk0Atd4o1YqRjdiduYgF3L2jxuix1oRD4peoM9VmJWDKQY3ZmLjwNGZ
         Ar5j/rpz6KtnVyTxyllhukKfTJzN9r25+oRWE6ky2ckA7cL/E1VEflow5/enpRdQJ9ZS
         OjT3qytDOmz3moW0xIFi2SdH8by6ElmEb5xJ7exli1oIHxkQknNQubz3X5+xmB2GWzgV
         epGQ==
X-Gm-Message-State: AO0yUKU1FTFFEGn6cL+PXaxB64F1iIRJ+1FEkr/wJtNTcPN1B/Cw5fZ9
        JAdtvEedWkBenNJ9XQHJYSkBXIiYhV4=
X-Google-Smtp-Source: AK7set/mZ/r6Psi2z5TZaYXCps12LQvS/jdTAmq+XA5BNWGPitx6imXK8h7VyBlEGm0t9ADG4FP1ig==
X-Received: by 2002:a7b:c7d4:0:b0:3eb:25ff:3446 with SMTP id z20-20020a7bc7d4000000b003eb25ff3446mr22453213wmk.4.1680361854249;
        Sat, 01 Apr 2023 08:10:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n13-20020a7bc5cd000000b003ede3e54ed7sm6371896wmk.6.2023.04.01.08.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 08:10:54 -0700 (PDT)
Message-Id: <7c3235c79433147d992bf9e4642f1ba7329fbdd1.1680361840.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
References: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 01 Apr 2023 15:10:33 +0000
Subject: [PATCH 20/24] strbuf: move forward declarations to beginning of file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 strbuf.h | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/strbuf.h b/strbuf.h
index 3dfeadb44c2..547696fb233 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -1,6 +1,8 @@
 #ifndef STRBUF_H
 #define STRBUF_H
 
+struct object_id;
+struct repository;
 struct string_list;
 
 /**
@@ -72,12 +74,6 @@ struct strbuf {
 extern char strbuf_slopbuf[];
 #define STRBUF_INIT  { .buf = strbuf_slopbuf }
 
-/*
- * Predeclare this here, since cache.h includes this file before it defines the
- * struct.
- */
-struct object_id;
-
 /**
  * Life Cycle Functions
  * --------------------
@@ -634,7 +630,6 @@ void strbuf_list_free(struct strbuf **list);
  * Add the abbreviation, as generated by repo_find_unique_abbrev(), of `sha1` to
  * the strbuf `sb`.
  */
-struct repository;
 void strbuf_repo_add_unique_abbrev(struct strbuf *sb, struct repository *repo,
 				   const struct object_id *oid, int abbrev_len);
 void strbuf_add_unique_abbrev(struct strbuf *sb, const struct object_id *oid,
-- 
gitgitgadget

