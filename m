Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED92C433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 18:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbiGSSeF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 14:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238223AbiGSSd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 14:33:56 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D2735D0C6
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:33:54 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id a18-20020a05600c349200b003a30de68697so1414454wmq.0
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=z+L9+tPr9fjSOm+ow1CUgMKdAgsHWFJvdTFI6Y5m8Js=;
        b=KH1QNFVJX7pmuVaCHYeuoG5/RidMAM7Gwt9uFENn6I01leg8lt/QdFe+d/05BD4oH5
         oG3SVaI2Lk4U0Q9ATig44RrOJ/karS8NxEmFYw0L9hU4QhnP564TR8IaU6SguaQGCcJn
         81Bk4OKgfabT7fCfv8Apqcr7EQwgWg5oK08HSic6gyKNwTIitq4fwfr9St3zw8+EM5l7
         xrZSdPv79DOQrvGK8m5MUoutM3W9a9u0EMBMu5GJ+uDjc7eXCwJpHTOHxyl/1Hc56mFt
         MdNYSREo4Yef0RveXQo0TzzXwuK9CHZYmqiZSxsZUKujAG76gYXoTowcwtj8Y/edwCnx
         f2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=z+L9+tPr9fjSOm+ow1CUgMKdAgsHWFJvdTFI6Y5m8Js=;
        b=h7UaNybvAF/EoMfE1BzwbdnRodf3csBhXaS5IXa9w7jfAcL6KLjK8JTpxtrzoRpbEP
         NaWKh6B5N15Dt7DT8HRFUAgpWBbLBpcdImvRGqUrH0keF7jehpMn8EcU3hWfQD45xTL+
         bjZRvpWmPl1G7zVe0qTl2cwOj3nTRh7TZsTmkMtedqAPBZ9iaWN1jU+5Kg1pqV8ARE+/
         4R9vDSe7v8XcMzalPkVTvxVuKZSwQ3C/ZK/Z+jsXkkwthDSFhsCTUziOFuIcnbWji5+8
         f/DojJDfn/11xTtmgEnaXxx5gaCEN7lRN7s76OUbxOFL9rdC1rVCmCCmf9GEzGtDcozc
         gZrA==
X-Gm-Message-State: AJIora9UcqppG0ouGINjReeyIOakkVUGRu/JH9Dql106o6hMdUCvv9qS
        Uuy8qy9VgJVlpSp6+8dr6VcgOffeIEk=
X-Google-Smtp-Source: AGRyM1sS9SB+dxvBmtg/Nu+MmUr/W1AJNIyvzDTZigiMCKgCqBhXH36JkJilypjE2NtxzYf/8YOWcg==
X-Received: by 2002:a05:600c:2053:b0:3a3:1dd7:956a with SMTP id p19-20020a05600c205300b003a31dd7956amr563557wmg.66.1658255632304;
        Tue, 19 Jul 2022 11:33:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c1c1700b003a32251c3f9sm3595814wms.5.2022.07.19.11.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 11:33:51 -0700 (PDT)
Message-Id: <d1cce4f06aa440cd0fb7992a35a9a28e9407e19b.1658255624.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1247.v5.git.1658255624.gitgitgadget@gmail.com>
References: <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
        <pull.1247.v5.git.1658255624.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Jul 2022 18:33:36 +0000
Subject: [PATCH v5 04/12] rebase-interactive: update 'merge' description
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The 'merge' command description for the todo list documentation in an
interactive rebase has multiple lines. The lines other than the first
one start with dots ('.') while the similar multi-line documentation for
'fixup' does not. This description only appears in the comment text of
the todo file during an interactive rebase.

The 'merge' command was documented when interactive rebase was first
ported to C in 145e05ac44b (rebase -i: rewrite append_todo_help() in C,
2018-08-10). These dots might have been carried over from the previous
shell implementation.

The 'fixup' command was documented more recently in 9e3cebd97cb (rebase
-i: add fixup [-C | -c] command, 2021-01-29).

Looking at the output in an editor, my personal opinion is that the dots
are unnecessary and noisy. Remove them now before adding more commands
with multi-line documentation.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 rebase-interactive.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rebase-interactive.c b/rebase-interactive.c
index 87649d0c016..22394224faa 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -54,9 +54,9 @@ void append_todo_help(int command_count,
 "l, label <label> = label current HEAD with a name\n"
 "t, reset <label> = reset HEAD to a label\n"
 "m, merge [-C <commit> | -c <commit>] <label> [# <oneline>]\n"
-".       create a merge commit using the original merge commit's\n"
-".       message (or the oneline, if no original merge commit was\n"
-".       specified); use -c <commit> to reword the commit message\n"
+"        create a merge commit using the original merge commit's\n"
+"        message (or the oneline, if no original merge commit was\n"
+"        specified); use -c <commit> to reword the commit message\n"
 "\n"
 "These lines can be re-ordered; they are executed from top to bottom.\n");
 	unsigned edit_todo = !(shortrevisions && shortonto);
-- 
gitgitgadget

