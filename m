Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D498C19F2D
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 16:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239199AbiHDQ3b (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 12:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237680AbiHDQ3T (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 12:29:19 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030B167CBC
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 09:29:04 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id h34-20020a05600c49a200b003a5165eae0fso118614wmp.4
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 09:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=g2jvcRB+75XlnTeEuY0rS8adDkZUA06GD9b+6U0gEqY=;
        b=ZKPHkU2fVjEjU6FyHgtf8W7PlZXG2wi+m7njY6uCvnDm1q+5eWlxkF8MBQoN2lLGe2
         49oCJ2NYTOJA3pXg592zJFTNXlpWCZzeUnDytHoHltlE/ooQLmdGViMixtv4v6txrgSr
         PnCUQLjrcfEH8GI+ijFuk50CMlOnbI7HsXe1xUpvXyZPIyBVkJG0DKXcciYNYOLZjAxf
         RiKQ5mxflkyOUw0YVG5+AGzOT0DxRb05/OVW9296kz1hYHjF9gtCvrEB/Rk/5pxpZljk
         +eKGmVdFdbJQ1/IOu4Co4sJy5lqKh5GyEQN1yvA0Cp8WrsLTZjnHRPEDzPeucENvHGXM
         jj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=g2jvcRB+75XlnTeEuY0rS8adDkZUA06GD9b+6U0gEqY=;
        b=yQ13g7vREiTjc/T5UhtrV0WtI1q1bWKB93hehmEbj6UwJwCamTPTSL/fxvHqfKJ6hl
         b/T+fb4qLcZsvHNB6fqjXZMK0OlGWvAZ0uvrWZPiYr2M6twPQBkbKvf610U3Bq8Zred0
         AemIWm1gzGri/kJtsJOErI8WA9DNSAdzlWbZnDtdzuTt9CfxACaJJtrOx3592AUH1Gjv
         8n6GoY7lx569J6WgPnBm2tO6SynrnB1WH2RszyOs/Fp8P39ZxBbcC7iLxSAglR6hAf00
         2j3YOYGPgQG4wtzRX8llcKBWX/fbsY+kvDDMPRxzPPcCOsYg4rRaRre4OaiIkqijLSwm
         utIA==
X-Gm-Message-State: ACgBeo2WRIGFOfX0AHf67/HUbxUpnr1AovBQ2n0P2tLoZKWf2Rcrg0Rz
        c7WYYmqnwDxuQXz6hkyx0DF8Ghgk6ikQ2g==
X-Google-Smtp-Source: AA6agR49PK0+2gaq35OacZlprYwjFF1nGMy7/shYUxkK3jX0Takggpm8FrdOYyfuZnL2zptDSm5UkA==
X-Received: by 2002:a05:600c:2244:b0:3a5:1207:a1aa with SMTP id a4-20020a05600c224400b003a51207a1aamr2076133wmm.176.1659630542812;
        Thu, 04 Aug 2022 09:29:02 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n66-20020a1ca445000000b003a513ee7830sm1868063wme.27.2022.08.04.09.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 09:29:02 -0700 (PDT)
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
Subject: [PATCH v8 10/12] docs: move pack format docs to man section 5
Date:   Thu,  4 Aug 2022 18:28:39 +0200
Message-Id: <patch-v8-10.12-576c1fef4b3-20220804T162138Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.g61622908797
In-Reply-To: <cover-v8-00.12-00000000000-20220804T162138Z-avarab@gmail.com>
References: <cover-v7-00.10-00000000000-20220802T125258Z-avarab@gmail.com> <cover-v8-00.12-00000000000-20220804T162138Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Continue the move of existing Documentation/technical/* protocol and
file-format documentation into our main documentation space by moving
the various documentation pertaining to the *.pack format and related
files, and updating things that refer to it to link to the new
location.

By moving these we can properly link from the newly created
gitformat-commit-graph to a gitformat-chunk-format page.

Integrating "Documentation/technical/bitmap-format.txt" and
"Documentation/technical/cruft-packs.txt" might logically be part of
this change, but as those cover parts of the wider "pack
format" (including associated files) that's documented outside of
"Documentation/technical/pack-format.txt" let's leave those for now,
subsequent commit(s) will address those.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/Makefile                        |  3 +-
 Documentation/config/pack.txt                 |  2 +-
 Documentation/git-bundle.txt                  |  3 +-
 Documentation/git-multi-pack-index.txt        |  4 +--
 .../chunk-format.txt => gitformat-chunk.txt}  | 25 +++++++++++---
 Documentation/gitformat-commit-graph.txt      |  2 +-
 Documentation/gitformat-index.txt             |  2 +-
 .../pack-format.txt => gitformat-pack.txt}    | 34 +++++++++++++++++--
 Documentation/gitprotocol-pack.txt            |  2 +-
 .../howto/recover-corrupted-object-harder.txt |  2 +-
 .../technical/hash-function-transition.txt    |  2 +-
 Documentation/user-manual.txt                 |  2 +-
 cache.h                                       |  3 +-
 command-list.txt                              |  2 ++
 pack-revindex.h                               |  2 +-
 15 files changed, 68 insertions(+), 22 deletions(-)
 rename Documentation/{technical/chunk-format.txt => gitformat-chunk.txt} (91%)
 rename Documentation/{technical/pack-format.txt => gitformat-pack.txt} (95%)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index d122d1751d8..d4a4a8c8b7d 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -25,8 +25,10 @@ MAN1_TXT += gitweb.txt
 # man5 / man7 guides (note: new guides should also be added to command-list.txt)
 MAN5_TXT += gitattributes.txt
 MAN5_TXT += gitformat-bundle.txt
+MAN5_TXT += gitformat-chunk.txt
 MAN5_TXT += gitformat-commit-graph.txt
 MAN5_TXT += gitformat-index.txt
+MAN5_TXT += gitformat-pack.txt
 MAN5_TXT += gitformat-signature.txt
 MAN5_TXT += githooks.txt
 MAN5_TXT += gitignore.txt
@@ -108,7 +110,6 @@ TECH_DOCS += technical/hash-function-transition
 TECH_DOCS += technical/http-protocol
 TECH_DOCS += technical/long-running-process-protocol
 TECH_DOCS += technical/multi-pack-index
-TECH_DOCS += technical/pack-format
 TECH_DOCS += technical/pack-heuristics
 TECH_DOCS += technical/parallel-checkout
 TECH_DOCS += technical/partial-clone
diff --git a/Documentation/config/pack.txt b/Documentation/config/pack.txt
index ad7f73a1ead..3e581eab84a 100644
--- a/Documentation/config/pack.txt
+++ b/Documentation/config/pack.txt
@@ -166,7 +166,7 @@ permuted into their appropriate location when writing a new bitmap.
 
 pack.writeReverseIndex::
 	When true, git will write a corresponding .rev file (see:
-	link:../technical/pack-format.html[Documentation/technical/pack-format.txt])
+	linkgit:gitformat-pack[5])
 	for each new packfile that it writes in all places except for
 	linkgit:git-fast-import[1] and in the bulk checkin mechanism.
 	Defaults to false.
diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index f0b1282b918..6da61722431 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -57,8 +57,7 @@ size. That they're "thin" under the hood is merely noted here as a
 curiosity, and as a reference to other documentation.
 
 See linkgit:gitformat-bundle[5] for more details and the discussion of
-"thin pack" in link:technical/pack-format.html[the pack format
-documentation] for further details.
+"thin pack" in linkgit:gitformat-pack[5] for further details.
 
 OPTIONS
 -------
diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
index c588fb91af1..a48c3d5ea63 100644
--- a/Documentation/git-multi-pack-index.txt
+++ b/Documentation/git-multi-pack-index.txt
@@ -128,8 +128,8 @@ $ git multi-pack-index verify
 SEE ALSO
 --------
 See link:technical/multi-pack-index.html[The Multi-Pack-Index Design
-Document] and link:technical/pack-format.html[The Multi-Pack-Index
-Format] for more information on the multi-pack-index feature.
+Document] and linkgit:gitformat-pack[5] for more information on the
+multi-pack-index feature and its file format.
 
 
 GIT
diff --git a/Documentation/technical/chunk-format.txt b/Documentation/gitformat-chunk.txt
similarity index 91%
rename from Documentation/technical/chunk-format.txt
rename to Documentation/gitformat-chunk.txt
index f36ce42f37c..57202ede273 100644
--- a/Documentation/technical/chunk-format.txt
+++ b/Documentation/gitformat-chunk.txt
@@ -1,11 +1,24 @@
-Chunk-based file formats
-========================
+gitformat-chunk(5)
+==================
+
+NAME
+----
+gitformat-chunk - Chunk-based file formats
+
+SYNOPSIS
+--------
+
+Used by linkgit:gitformat-commit-graph[5] and the "MIDX" format (see
+the pack format documentation in linkgit:gitformat-pack[5]).
+
+DESCRIPTION
+-----------
 
 Some file formats in Git use a common concept of "chunks" to describe
 sections of the file. This allows structured access to a large file by
 scanning a small "table of contents" for the remaining data. This common
 format is used by the `commit-graph` and `multi-pack-index` files. See
-link:technical/pack-format.html[the `multi-pack-index` format] and
+the `multi-pack-index` format in linkgit:gitformat-pack[5] and
 the `commit-graph` format in linkgit:gitformat-commit-graph[5] for
 how they use the chunks to describe structured data.
 
@@ -113,4 +126,8 @@ for future formats:
 * *multi-pack-index:* see `write_midx_internal()` and `load_multi_pack_index()`
   in `midx.c` for how the chunk-format API is used to write and
   parse the multi-pack-index file format documented in
-  link:technical/pack-format.html[the multi-pack-index file format].
+  the multi-pack-index file format section of linkgit:gitformat-pack[5].
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/gitformat-commit-graph.txt b/Documentation/gitformat-commit-graph.txt
index 108dc2295c0..7324665716d 100644
--- a/Documentation/gitformat-commit-graph.txt
+++ b/Documentation/gitformat-commit-graph.txt
@@ -75,7 +75,7 @@ All multi-byte numbers are in network byte order.
       ID appears at most once.
 
   The CHUNK LOOKUP matches the table of contents from
-  link:technical/chunk-format.html[the chunk-based file format].
+  the chunk-based file format, see linkgit:gitformat-chunk[5]
 
   The remaining data in the body is described one chunk at a time, and
   these chunks may be given in any order. Chunks are required unless
diff --git a/Documentation/gitformat-index.txt b/Documentation/gitformat-index.txt
index 9c3844298b8..015cb21bdc0 100644
--- a/Documentation/gitformat-index.txt
+++ b/Documentation/gitformat-index.txt
@@ -139,7 +139,7 @@ Git index format
     entry is encoded as if the path name for the previous entry is an
     empty string).  At the beginning of an entry, an integer N in the
     variable width encoding (the same encoding as the offset is encoded
-    for OFS_DELTA pack entries; see pack-format.txt) is stored, followed
+    for OFS_DELTA pack entries; see linkgit:gitformat-pack[5]) is stored, followed
     by a NUL-terminated string S.  Removing N bytes from the end of the
     path name for the previous entry, and replacing it with the string S
     yields the path name for this entry.
diff --git a/Documentation/technical/pack-format.txt b/Documentation/gitformat-pack.txt
similarity index 95%
rename from Documentation/technical/pack-format.txt
rename to Documentation/gitformat-pack.txt
index b520aa9c45b..546c99f8871 100644
--- a/Documentation/technical/pack-format.txt
+++ b/Documentation/gitformat-pack.txt
@@ -1,5 +1,29 @@
-Git pack format
-===============
+gitformat-pack(5)
+=================
+
+NAME
+----
+gitformat-pack - Git pack format
+
+
+SYNOPSIS
+--------
+[verse]
+$GIT_DIR/objects/pack/pack-*.{pack,idx}
+$GIT_DIR/objects/pack/pack-*.rev
+$GIT_DIR/objects/pack/multi-pack-index
+
+DESCRIPTION
+-----------
+
+The Git pack format is now Git stores most of its primary repository
+data. Over the lietime af a repository loose objects (if any) and
+smaller packs are consolidated into larger pack(s). See
+linkgit:git-gc[1] and linkgit:git-pack-objects[1].
+
+The pack format is also used over-the-wire, see
+e.g. linkgit:gitprotocol-v2[5], as well as being a part of
+other container formats in the case of linkgit:gitformat-bundle[5].
 
 == Checksums and object IDs
 
@@ -356,7 +380,7 @@ CHUNK LOOKUP:
 	    using the next chunk position if necessary.)
 
 	The CHUNK LOOKUP matches the table of contents from
-	link:technical/chunk-format.html[the chunk-based file format].
+	the chunk-based file format, see linkgit:gitformat-chunk[5].
 
 	The remaining data in the body is described one chunk at a time, and
 	these chunks may be given in any order. Chunks are required unless
@@ -482,3 +506,7 @@ packs arranged in MIDX order (with the preferred pack coming first).
 
 The MIDX's reverse index is stored in the optional 'RIDX' chunk within
 the MIDX itself.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/gitprotocol-pack.txt b/Documentation/gitprotocol-pack.txt
index 8a4de6decd0..93b30b88450 100644
--- a/Documentation/gitprotocol-pack.txt
+++ b/Documentation/gitprotocol-pack.txt
@@ -467,7 +467,7 @@ Now that the client and server have finished negotiation about what
 the minimal amount of data that needs to be sent to the client is, the server
 will construct and send the required data in packfile format.
 
-See pack-format.txt for what the packfile itself actually looks like.
+See linkgit:gitformat-pack[5] for what the packfile itself actually looks like.
 
 If 'side-band' or 'side-band-64k' capabilities have been specified by
 the client, the server will send the packfile data multiplexed.
diff --git a/Documentation/howto/recover-corrupted-object-harder.txt b/Documentation/howto/recover-corrupted-object-harder.txt
index 8994e2559ea..5efb4fe81ff 100644
--- a/Documentation/howto/recover-corrupted-object-harder.txt
+++ b/Documentation/howto/recover-corrupted-object-harder.txt
@@ -68,7 +68,7 @@ Note that the "object" file isn't fit for feeding straight to zlib; it
 has the git packed object header, which is variable-length. We want to
 strip that off so we can start playing with the zlib data directly. You
 can either work your way through it manually (the format is described in
-link:../technical/pack-format.html[Documentation/technical/pack-format.txt]),
+linkgit:gitformat-pack[5]),
 or you can walk through it in a debugger. I did the latter, creating a
 valid pack like:
 
diff --git a/Documentation/technical/hash-function-transition.txt b/Documentation/technical/hash-function-transition.txt
index 260224b0331..e2ac36dd210 100644
--- a/Documentation/technical/hash-function-transition.txt
+++ b/Documentation/technical/hash-function-transition.txt
@@ -205,7 +205,7 @@ SHA-1 content.
 Object storage
 ~~~~~~~~~~~~~~
 Loose objects use zlib compression and packed objects use the packed
-format described in Documentation/technical/pack-format.txt, just like
+format described in linkgit:gitformat-pack[5], just like
 today. The content that is compressed and stored uses SHA-256 content
 instead of SHA-1 content.
 
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 865074bed4e..ca9decdd952 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -3133,7 +3133,7 @@ those "loose" objects.
 You can save space and make Git faster by moving these loose objects in
 to a "pack file", which stores a group of objects in an efficient
 compressed format; the details of how pack files are formatted can be
-found in link:technical/pack-format.html[pack format].
+found in link:gitformat-pack[5].
 
 To put the loose objects into a pack, just run git repack:
 
diff --git a/cache.h b/cache.h
index 4aa1bd079d5..302810b353a 100644
--- a/cache.h
+++ b/cache.h
@@ -475,8 +475,7 @@ extern struct index_state the_index;
 
 /*
  * Values in this enum (except those outside the 3 bit range) are part
- * of pack file format. See Documentation/technical/pack-format.txt
- * for more information.
+ * of pack file format. See gitformat-pack(5) for more information.
  */
 enum object_type {
 	OBJ_BAD = -1,
diff --git a/command-list.txt b/command-list.txt
index 68212e3c1bd..5394eefb6ee 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -210,8 +210,10 @@ gitdiffcore                             guide
 giteveryday                             guide
 gitfaq                                  guide
 gitformat-bundle                        developerinterfaces
+gitformat-chunk                         developerinterfaces
 gitformat-commit-graph                  developerinterfaces
 gitformat-index                         developerinterfaces
+gitformat-pack                          developerinterfaces
 gitformat-signature                     developerinterfaces
 gitglossary                             guide
 githooks                                userinterfaces
diff --git a/pack-revindex.h b/pack-revindex.h
index 74f4eae668d..4974e75eb4d 100644
--- a/pack-revindex.h
+++ b/pack-revindex.h
@@ -22,7 +22,7 @@
  *
  *   - pack position refers to an object's position within a non-existent pack
  *     described by the MIDX. The pack structure is described in
- *     Documentation/technical/pack-format.txt.
+ *     gitformat-pack(5).
  *
  *     It is effectively a concatanation of all packs in the MIDX (ordered by
  *     their numeric ID within the MIDX) in their original order within each
-- 
2.37.1.1233.g61622908797

