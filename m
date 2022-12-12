Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9A0C4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 01:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbiLLBmc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Dec 2022 20:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLLBma (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Dec 2022 20:42:30 -0500
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659E1BCA4
        for <git@vger.kernel.org>; Sun, 11 Dec 2022 17:42:29 -0800 (PST)
Date:   Mon, 12 Dec 2022 01:42:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1670809347; x=1671068547;
        bh=rum4MW7I63EG/mCdkSAeh1Me8WuGImL2AN199VGFgjg=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=mSGpb9IiZR1rGt62FrJ4A0VldMm+M03lok0Kp/1ji4DDqyqQ5Et6KGdtnI1uoqUZq
         UzkbKavUfnm5vPClVODMoSKulMkXAIk9D6tljHAPrEpLrQL8rSbr/6JlZnPeabqvJz
         Zy7ud6oocv9XPuIIoOQDNpYWUTInMdoVKiH9HErJGw6ss4gkv102ReeLP1sXDp8DhA
         iLlmcB7q+eDokO0VpNZsiEAoKFvJeZqN0NXGZI6xhSPQ3RhBORSRiaAJB7S7bQih1c
         PhN5GXQSsJaPKbxn/kPDJBIG5Rk30T1JX1P/Mdi2IlmSSQ1k/bH66Obq0Jx58VEWHg
         A4W+HgYAyvAsg==
To:     git@vger.kernel.org
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     Jacob Abel <jacobabel@nullpo.dev>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: [PATCH v4 1/3] worktree add: Include -B in usage docs
Message-ID: <20221212014003.20290-2-jacobabel@nullpo.dev>
In-Reply-To: <20221212014003.20290-1-jacobabel@nullpo.dev>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104213401.17393-1-jacobabel@nullpo.dev> <20221110233137.10414-1-jacobabel@nullpo.dev> <20221212014003.20290-1-jacobabel@nullpo.dev>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While -B behavior is already documented, it was not included in the
usage docs for either the man page or the help text. This change fixes
that and brings the usage docs in line with how the flags are documented
in other commands such as git checkout.

Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
---
 Documentation/git-worktree.txt | 2 +-
 builtin/worktree.c             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.tx=
t
index 063d6eeb99..4dd658012b 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git worktree add' [-f] [--detach] [--checkout] [--lock [--reason <string>=
]]
-=09=09   [-b <new-branch>] <path> [<commit-ish>]
+=09=09   [[-b | -B] <new-branch>] <path> [<commit-ish>]
 'git worktree list' [-v | --porcelain [-z]]
 'git worktree lock' [--reason <string>] <worktree>
 'git worktree move' <worktree> <new-path>
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 4a24d53be1..fccb17f070 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -17,7 +17,7 @@

 #define BUILTIN_WORKTREE_ADD_USAGE \
 =09N_("git worktree add [-f] [--detach] [--checkout] [--lock [--reason <st=
ring>]]\n" \
-=09   "                 [-b <new-branch>] <path> [<commit-ish>]")
+=09   "                 [[-b | -B] <new-branch>] <path> [<commit-ish>]")
 #define BUILTIN_WORKTREE_LIST_USAGE \
 =09N_("git worktree list [-v | --porcelain [-z]]")
 #define BUILTIN_WORKTREE_LOCK_USAGE \
--
2.37.4


