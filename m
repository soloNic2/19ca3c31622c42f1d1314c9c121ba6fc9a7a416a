Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C435C433F5
	for <git@archiver.kernel.org>; Sun,  3 Apr 2022 12:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349461AbiDCM4n (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Apr 2022 08:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235429AbiDCM4m (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Apr 2022 08:56:42 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69531FCF6
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 05:54:47 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id m30so10645838wrb.1
        for <git@vger.kernel.org>; Sun, 03 Apr 2022 05:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sMULGgKSLCpcP8kqXWyr6mNFITaQ4HI/BjQlbDU9IVM=;
        b=Y+38QVGQ+q52eT11K4XzyhDnv5suo6Pb7Yr5h1F0KMA6LSpYToLD1YhyrEPDdZDqVE
         0OiS2v3vqJI7qJrFED/TtOUZxKPzrePZhvrBk9vBGpE5oM5sllnYPN2E/kleaJreRCJU
         17pZU1AB7EVL3FDyOdw3BoWAUPqlyy/vrzH3mPaKzTMxQSpaY2UzmojSoq7W1yfLhBnv
         J8xEjHo6XS/9XhU2qJ8RWlyqTbpnvP676pHXDKLVVAhf8f2j+9pbZ43xxLJQnvO0eRsE
         CxUdfvwQbFtNixHAyWGy9OdgLdwRWSUg85voxBQ2IAv1wJDRVqNnuJp7n8cxD69QQuAp
         gw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sMULGgKSLCpcP8kqXWyr6mNFITaQ4HI/BjQlbDU9IVM=;
        b=i8VnNCudsuXgjVrVrd7FVjVCz6zeTsqh7ll6sLOGct9hxHN9ivLjoRH3q4ah30+sSp
         hCso/F0c3zPX48Fs1GwFAejo1txLEMLIVo8SE8CbawJYlCSTxMh5GS8KWjWnfnLRqMXU
         OjWkI5hJjNXHWM1gizDl+zu6pfQ9AALKol3swp4EQjV7sNUDRsPrUJPzXw8HaWlI0CB8
         oWJNCyx8c2XR8sF+bZmcSRACTZJZVLpW30ObuBduXZTBdqB1bG/zRa0QeXqtoI/ehOFc
         LxHe4Gt0gUZ3de6bGTAtzjKVF5GxVDWWHarc2eMcayLWKe/d3dikEMTAjsjgflvCAz+P
         ssag==
X-Gm-Message-State: AOAM532qp7B/yw2/yYUlpzvTJdSyVGpplaD1Wct4Dz/Iw6WMP2Z0776h
        2Sxrdrfa3781AoiJsmqi/9M=
X-Google-Smtp-Source: ABdhPJzspNJF0ca/VvO1cqvU4EN7y1md+3cgpDafmd2i33ucG86S8ZFOaSSqgSzqnugmqfrDqSrE8Q==
X-Received: by 2002:a05:6000:1044:b0:1eb:f72c:7f25 with SMTP id c4-20020a056000104400b001ebf72c7f25mr13757331wrx.155.1648990486149;
        Sun, 03 Apr 2022 05:54:46 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.224])
        by smtp.gmail.com with ESMTPSA id m3-20020a5d64a3000000b00203ed35b0aesm11052190wrp.108.2022.04.03.05.54.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Apr 2022 05:54:45 -0700 (PDT)
Message-ID: <02da5550-3137-b579-93c5-bf245a8cbc2a@gmail.com>
Date:   Sun, 3 Apr 2022 13:54:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 18/27] revisions API: have release_revisions() release
 "cmdline"
Content-Language: en-GB-large
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
 <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com>
 <patch-v5-18.27-7987c748ba4-20220402T102002Z-avarab@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <patch-v5-18.27-7987c748ba4-20220402T102002Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 02/04/2022 11:49, Ævar Arnfjörð Bjarmason wrote:
> Extend the the release_revisions() function so that it frees the
> "cmdline" in the "struct rev_info". This in combination with a
> preceding change to free "commits" and "mailmap" means that we can
> whitelist another test under "TEST_PASSES_SANITIZE_LEAK=true".
> 
> There was a proposal in [1] to do away with xstrdup()-ing this
> add_rev_cmdline(), perhaps that would be worthwhile, but for now let's
> just free() it.
> 
> We could also make that a "char *" in "struct rev_cmdline_entry"
> itself, but since we own it let's expose it as a constant to outside
> callers. I proposed that in [2] but have since changed my mind. See
> 14d30cdfc04 (ref-filter: fix memory leak in `free_array_item()`,
> 2019-07-10), c514c62a4fd (checkout: fix leak of non-existent branch
> names, 2020-08-14) and other log history hits for "free((char *)" for
> prior art.
> 
> This includes the tests we had false-positive passes on before my
> 6798b08e848 (perl Git.pm: don't ignore signalled failure in
> _cmd_close(), 2022-02-01), now they pass for real.
> 
> Since there are 66 tests matching t/t[0-9]*git-svn*.sh it's easier to
> list those that don't pass than to touch most of those 66. So let's
> introduce a "TEST_FAILS_SANITIZE_LEAK=true", which if set in the tests
> won't cause lib-git-svn.sh to set "TEST_PASSES_SANITIZE_LEAK=true.
> 
> This change also marks all the tests that we removed
> "TEST_FAILS_SANITIZE_LEAK=true" from in an earlier commit due to
> removing the UNLEAK() from cmd_format_patch(), we can now assert that
> its API use doesn't leak any "struct rev_info" memory.
> 
> This change also made commit "t5503-tagfollow.sh" pass on current
> master, but that would regress when combined with
> ps/fetch-atomic-fixup's de004e848a9 (t5503: simplify setup of test
> which exercises failure of backfill, 2022-03-03) (through no fault of
> that topic, that change started using "git clone" in the test, which
> has an outstanding leak). Let's leave that test out for now to avoid
> in-flight semantic conflicts.
> 
> 1. https://lore.kernel.org/git/YUj%2FgFRh6pwrZalY@carlos-mbp.lan/
> 2. https://lore.kernel.org/git/87o88obkb1.fsf@evledraar.gmail.com/
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   revision.c                                 | 12 ++++++++++++
>   t/lib-git-svn.sh                           |  4 ++++
>   t/t0062-revision-walking.sh                |  1 +
>   t/t0101-at-syntax.sh                       |  2 ++
>   t/t1060-object-corruption.sh               |  1 +
>   t/t3303-notes-subtrees.sh                  |  1 +
>   t/t3305-notes-fanout.sh                    |  1 +
>   t/t3408-rebase-multi-line.sh               |  1 +
>   t/t4027-diff-submodule.sh                  |  1 +
>   t/t4128-apply-root.sh                      |  1 +
>   t/t4212-log-corrupt.sh                     |  1 +
>   t/t5515-fetch-merge-logic.sh               |  1 +
>   t/t5518-fetch-exit-status.sh               |  1 +
>   t/t6002-rev-list-bisect.sh                 |  1 +
>   t/t6003-rev-list-topo-order.sh             |  1 +
>   t/t6005-rev-list-count.sh                  |  1 +
>   t/t6018-rev-list-glob.sh                   |  1 +
>   t/t6100-rev-list-in-order.sh               |  1 +
>   t/t9100-git-svn-basic.sh                   |  1 +
>   t/t9101-git-svn-props.sh                   |  2 ++
>   t/t9104-git-svn-follow-parent.sh           |  2 ++
>   t/t9106-git-svn-commit-diff-clobber.sh     |  2 ++
>   t/t9115-git-svn-dcommit-funky-renames.sh   |  1 +
>   t/t9116-git-svn-log.sh                     |  2 ++
>   t/t9122-git-svn-author.sh                  |  2 ++
>   t/t9127-git-svn-partial-rebuild.sh         |  2 ++
>   t/t9129-git-svn-i18n-commitencoding.sh     |  1 +
>   t/t9132-git-svn-broken-symlink.sh          |  1 +
>   t/t9139-git-svn-non-utf8-commitencoding.sh |  1 +
>   t/t9146-git-svn-empty-dirs.sh              |  2 ++
>   t/t9148-git-svn-propset.sh                 |  1 +
>   t/t9151-svn-mergeinfo.sh                   |  1 +
>   t/t9160-git-svn-preserve-empty-dirs.sh     |  1 +
>   t/t9162-git-svn-dcommit-interactive.sh     |  2 ++
>   t/t9164-git-svn-dcommit-concurrent.sh      |  2 ++
>   t/t9501-gitweb-standalone-http-status.sh   |  1 +
>   36 files changed, 60 insertions(+)
> 
> diff --git a/revision.c b/revision.c
> index 622f0faecc4..c81506fa22f 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2926,6 +2926,17 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>   	return left;
>   }
>   
> +static void release_revisions_cmdline(struct rev_cmdline_info *cmdline)
> +{
> +	unsigned int i;
> +
> +	if (!cmdline)
> +		return;

I don't think we need this guard, the only instances of struct 
rev_cmdline_info exist within struct rev_info, as far as I can see it is 
never created on its own.

> +	for (i = 0; i < cmdline->nr; i++)
> +		free((char *)cmdline->rev[i].name);
> +	free(cmdline->rev);

This could just be in release_revisions()

Best Wishes

Phillip
> +}
> +
>   static void release_revisions_mailmap(struct string_list *mailmap)
>   {
>   	if (!mailmap)
> @@ -2938,6 +2949,7 @@ void release_revisions(struct rev_info *revs)
>   {
>   	free_commit_list(revs->commits);
>   	object_array_clear(&revs->pending);
> +	release_revisions_cmdline(&revs->cmdline);
>   	release_revisions_mailmap(revs->mailmap);
>   }
>   
> diff --git a/t/lib-git-svn.sh b/t/lib-git-svn.sh
> index 2fde2353fd3..ea28971e8ee 100644
> --- a/t/lib-git-svn.sh
> +++ b/t/lib-git-svn.sh
> @@ -1,3 +1,7 @@
> +if test -z "$TEST_FAILS_SANITIZE_LEAK"
> +then
> +	TEST_PASSES_SANITIZE_LEAK=true
> +fi
>   . ./test-lib.sh
>   
>   if test -n "$NO_SVN_TESTS"
> diff --git a/t/t0062-revision-walking.sh b/t/t0062-revision-walking.sh
> index 8e215867b8c..b9480c81781 100755
> --- a/t/t0062-revision-walking.sh
> +++ b/t/t0062-revision-walking.sh
> @@ -5,6 +5,7 @@
>   
>   test_description='Test revision walking api'
>   
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   
>   cat >run_twice_expected <<-EOF
> diff --git a/t/t0101-at-syntax.sh b/t/t0101-at-syntax.sh
> index a1998b558f9..878aadd64c9 100755
> --- a/t/t0101-at-syntax.sh
> +++ b/t/t0101-at-syntax.sh
> @@ -1,6 +1,8 @@
>   #!/bin/sh
>   
>   test_description='various @{whatever} syntax tests'
> +
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   
>   test_expect_success 'setup' '
> diff --git a/t/t1060-object-corruption.sh b/t/t1060-object-corruption.sh
> index bc89371f534..e8a58b15897 100755
> --- a/t/t1060-object-corruption.sh
> +++ b/t/t1060-object-corruption.sh
> @@ -1,6 +1,7 @@
>   #!/bin/sh
>   
>   test_description='see how we handle various forms of corruption'
> +
>   . ./test-lib.sh
>   
>   # convert "1234abcd" to ".git/objects/12/34abcd"
> diff --git a/t/t3303-notes-subtrees.sh b/t/t3303-notes-subtrees.sh
> index eac193757bf..bc9b791d1b9 100755
> --- a/t/t3303-notes-subtrees.sh
> +++ b/t/t3303-notes-subtrees.sh
> @@ -5,6 +5,7 @@ test_description='Test commit notes organized in subtrees'
>   GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>   export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>   
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   
>   number_of_commits=100
> diff --git a/t/t3305-notes-fanout.sh b/t/t3305-notes-fanout.sh
> index 9976d787f47..64a9915761a 100755
> --- a/t/t3305-notes-fanout.sh
> +++ b/t/t3305-notes-fanout.sh
> @@ -2,6 +2,7 @@
>   
>   test_description='Test that adding/removing many notes triggers automatic fanout restructuring'
>   
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   
>   path_has_fanout() {
> diff --git a/t/t3408-rebase-multi-line.sh b/t/t3408-rebase-multi-line.sh
> index cde3562e3a6..7b4607d72f2 100755
> --- a/t/t3408-rebase-multi-line.sh
> +++ b/t/t3408-rebase-multi-line.sh
> @@ -5,6 +5,7 @@ test_description='rebasing a commit with multi-line first paragraph.'
>   GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>   export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>   
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   
>   test_expect_success setup '
> diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
> index 295da987cce..40164ae07d2 100755
> --- a/t/t4027-diff-submodule.sh
> +++ b/t/t4027-diff-submodule.sh
> @@ -2,6 +2,7 @@
>   
>   test_description='difference in submodules'
>   
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   . "$TEST_DIRECTORY"/lib-diff.sh
>   
> diff --git a/t/t4128-apply-root.sh b/t/t4128-apply-root.sh
> index f6db5a79dd9..ed94c90204e 100755
> --- a/t/t4128-apply-root.sh
> +++ b/t/t4128-apply-root.sh
> @@ -2,6 +2,7 @@
>   
>   test_description='apply same filename'
>   
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   
>   test_expect_success 'setup' '
> diff --git a/t/t4212-log-corrupt.sh b/t/t4212-log-corrupt.sh
> index 0244888a5a7..30a219894bb 100755
> --- a/t/t4212-log-corrupt.sh
> +++ b/t/t4212-log-corrupt.sh
> @@ -2,6 +2,7 @@
>   
>   test_description='git log with invalid commit headers'
>   
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   
>   test_expect_success 'setup' '
> diff --git a/t/t5515-fetch-merge-logic.sh b/t/t5515-fetch-merge-logic.sh
> index 320d26796d2..c100a809c5e 100755
> --- a/t/t5515-fetch-merge-logic.sh
> +++ b/t/t5515-fetch-merge-logic.sh
> @@ -14,6 +14,7 @@ export GIT_TEST_PROTOCOL_VERSION
>   GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>   export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>   
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   
>   build_script () {
> diff --git a/t/t5518-fetch-exit-status.sh b/t/t5518-fetch-exit-status.sh
> index 5c4ac2556e7..c13120088fa 100755
> --- a/t/t5518-fetch-exit-status.sh
> +++ b/t/t5518-fetch-exit-status.sh
> @@ -8,6 +8,7 @@ test_description='fetch exit status test'
>   GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>   export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>   
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   
>   test_expect_success setup '
> diff --git a/t/t6002-rev-list-bisect.sh b/t/t6002-rev-list-bisect.sh
> index b95a0212adf..162cf50778d 100755
> --- a/t/t6002-rev-list-bisect.sh
> +++ b/t/t6002-rev-list-bisect.sh
> @@ -4,6 +4,7 @@
>   #
>   test_description='Tests git rev-list --bisect functionality'
>   
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   . "$TEST_DIRECTORY"/lib-t6000.sh # t6xxx specific functions
>   
> diff --git a/t/t6003-rev-list-topo-order.sh b/t/t6003-rev-list-topo-order.sh
> index 24d1836f417..1f7d7dd20c1 100755
> --- a/t/t6003-rev-list-topo-order.sh
> +++ b/t/t6003-rev-list-topo-order.sh
> @@ -5,6 +5,7 @@
>   
>   test_description='Tests git rev-list --topo-order functionality'
>   
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   . "$TEST_DIRECTORY"/lib-t6000.sh # t6xxx specific functions
>   
> diff --git a/t/t6005-rev-list-count.sh b/t/t6005-rev-list-count.sh
> index e960049f647..0729f800c3c 100755
> --- a/t/t6005-rev-list-count.sh
> +++ b/t/t6005-rev-list-count.sh
> @@ -2,6 +2,7 @@
>   
>   test_description='git rev-list --max-count and --skip test'
>   
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   
>   test_expect_success 'setup' '
> diff --git a/t/t6018-rev-list-glob.sh b/t/t6018-rev-list-glob.sh
> index 24b34add833..e1abc5c2b32 100755
> --- a/t/t6018-rev-list-glob.sh
> +++ b/t/t6018-rev-list-glob.sh
> @@ -5,6 +5,7 @@ test_description='rev-list/rev-parse --glob'
>   GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>   export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>   
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   
>   commit () {
> diff --git a/t/t6100-rev-list-in-order.sh b/t/t6100-rev-list-in-order.sh
> index e934bc239c5..88ed7bd75a7 100755
> --- a/t/t6100-rev-list-in-order.sh
> +++ b/t/t6100-rev-list-in-order.sh
> @@ -2,6 +2,7 @@
>   
>   test_description='rev-list testing in-commit-order'
>   
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./test-lib.sh
>   
>   test_expect_success 'setup a commit history with trees, blobs' '
> diff --git a/t/t9100-git-svn-basic.sh b/t/t9100-git-svn-basic.sh
> index fea41b3c360..7c5b847f584 100755
> --- a/t/t9100-git-svn-basic.sh
> +++ b/t/t9100-git-svn-basic.sh
> @@ -8,6 +8,7 @@ test_description='git svn basic tests'
>   GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>   export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>   
> +TEST_FAILS_SANITIZE_LEAK=true
>   . ./lib-git-svn.sh
>   
>   prepare_utf8_locale
> diff --git a/t/t9101-git-svn-props.sh b/t/t9101-git-svn-props.sh
> index 8b5681dd68a..d043e80fc34 100755
> --- a/t/t9101-git-svn-props.sh
> +++ b/t/t9101-git-svn-props.sh
> @@ -4,6 +4,8 @@
>   #
>   
>   test_description='git svn property tests'
> +
> +TEST_FAILS_SANITIZE_LEAK=true
>   . ./lib-git-svn.sh
>   
>   mkdir import
> diff --git a/t/t9104-git-svn-follow-parent.sh b/t/t9104-git-svn-follow-parent.sh
> index c7d8e0bf00f..5cf2ef4b8b0 100755
> --- a/t/t9104-git-svn-follow-parent.sh
> +++ b/t/t9104-git-svn-follow-parent.sh
> @@ -4,6 +4,8 @@
>   #
>   
>   test_description='git svn fetching'
> +
> +TEST_FAILS_SANITIZE_LEAK=true
>   . ./lib-git-svn.sh
>   
>   test_expect_success 'initialize repo' '
> diff --git a/t/t9106-git-svn-commit-diff-clobber.sh b/t/t9106-git-svn-commit-diff-clobber.sh
> index aec45bca3b7..3cab0b9720a 100755
> --- a/t/t9106-git-svn-commit-diff-clobber.sh
> +++ b/t/t9106-git-svn-commit-diff-clobber.sh
> @@ -2,6 +2,8 @@
>   #
>   # Copyright (c) 2006 Eric Wong
>   test_description='git svn commit-diff clobber'
> +
> +TEST_FAILS_SANITIZE_LEAK=true
>   . ./lib-git-svn.sh
>   
>   test_expect_success 'initialize repo' '
> diff --git a/t/t9115-git-svn-dcommit-funky-renames.sh b/t/t9115-git-svn-dcommit-funky-renames.sh
> index 743fbe1fe46..419f055721d 100755
> --- a/t/t9115-git-svn-dcommit-funky-renames.sh
> +++ b/t/t9115-git-svn-dcommit-funky-renames.sh
> @@ -5,6 +5,7 @@
>   
>   test_description='git svn dcommit can commit renames of files with ugly names'
>   
> +TEST_FAILS_SANITIZE_LEAK=true
>   . ./lib-git-svn.sh
>   
>   test_expect_success 'load repository with strange names' '
> diff --git a/t/t9116-git-svn-log.sh b/t/t9116-git-svn-log.sh
> index 0a9f1ef366d..34f6c80dea3 100755
> --- a/t/t9116-git-svn-log.sh
> +++ b/t/t9116-git-svn-log.sh
> @@ -4,6 +4,8 @@
>   #
>   
>   test_description='git svn log tests'
> +
> +TEST_FAILS_SANITIZE_LEAK=true
>   . ./lib-git-svn.sh
>   
>   test_expect_success 'setup repository and import' '
> diff --git a/t/t9122-git-svn-author.sh b/t/t9122-git-svn-author.sh
> index 9e8fe38e7ef..527ba3d2932 100755
> --- a/t/t9122-git-svn-author.sh
> +++ b/t/t9122-git-svn-author.sh
> @@ -1,6 +1,8 @@
>   #!/bin/sh
>   
>   test_description='git svn authorship'
> +
> +TEST_FAILS_SANITIZE_LEAK=true
>   . ./lib-git-svn.sh
>   
>   test_expect_success 'setup svn repository' '
> diff --git a/t/t9127-git-svn-partial-rebuild.sh b/t/t9127-git-svn-partial-rebuild.sh
> index 2e4789d061f..90b1b30dde5 100755
> --- a/t/t9127-git-svn-partial-rebuild.sh
> +++ b/t/t9127-git-svn-partial-rebuild.sh
> @@ -4,6 +4,8 @@
>   #
>   
>   test_description='git svn partial-rebuild tests'
> +
> +TEST_FAILS_SANITIZE_LEAK=true
>   . ./lib-git-svn.sh
>   
>   test_expect_success 'initialize svnrepo' '
> diff --git a/t/t9129-git-svn-i18n-commitencoding.sh b/t/t9129-git-svn-i18n-commitencoding.sh
> index 01e1e8a8f76..185248a4cd7 100755
> --- a/t/t9129-git-svn-i18n-commitencoding.sh
> +++ b/t/t9129-git-svn-i18n-commitencoding.sh
> @@ -4,6 +4,7 @@
>   
>   test_description='git svn honors i18n.commitEncoding in config'
>   
> +TEST_FAILS_SANITIZE_LEAK=true
>   . ./lib-git-svn.sh
>   
>   compare_git_head_with () {
> diff --git a/t/t9132-git-svn-broken-symlink.sh b/t/t9132-git-svn-broken-symlink.sh
> index aeceffaf7b0..4d8d0584b79 100755
> --- a/t/t9132-git-svn-broken-symlink.sh
> +++ b/t/t9132-git-svn-broken-symlink.sh
> @@ -2,6 +2,7 @@
>   
>   test_description='test that git handles an svn repository with empty symlinks'
>   
> +TEST_FAILS_SANITIZE_LEAK=true
>   . ./lib-git-svn.sh
>   test_expect_success 'load svn dumpfile' '
>   	svnadmin load "$rawsvnrepo" <<EOF
> diff --git a/t/t9139-git-svn-non-utf8-commitencoding.sh b/t/t9139-git-svn-non-utf8-commitencoding.sh
> index 22d80b0be2b..b7f756b2b7f 100755
> --- a/t/t9139-git-svn-non-utf8-commitencoding.sh
> +++ b/t/t9139-git-svn-non-utf8-commitencoding.sh
> @@ -4,6 +4,7 @@
>   
>   test_description='git svn refuses to dcommit non-UTF8 messages'
>   
> +TEST_FAILS_SANITIZE_LEAK=true
>   . ./lib-git-svn.sh
>   
>   # ISO-2022-JP can pass for valid UTF-8, so skipping that in this test
> diff --git a/t/t9146-git-svn-empty-dirs.sh b/t/t9146-git-svn-empty-dirs.sh
> index 80cb55fee70..79c26ed69c1 100755
> --- a/t/t9146-git-svn-empty-dirs.sh
> +++ b/t/t9146-git-svn-empty-dirs.sh
> @@ -3,6 +3,8 @@
>   # Copyright (c) 2009 Eric Wong
>   
>   test_description='git svn creates empty directories'
> +
> +TEST_FAILS_SANITIZE_LEAK=true
>   . ./lib-git-svn.sh
>   
>   test_expect_success 'initialize repo' '
> diff --git a/t/t9148-git-svn-propset.sh b/t/t9148-git-svn-propset.sh
> index aebb28995e5..6cc76a07b39 100755
> --- a/t/t9148-git-svn-propset.sh
> +++ b/t/t9148-git-svn-propset.sh
> @@ -5,6 +5,7 @@
>   
>   test_description='git svn propset tests'
>   
> +TEST_FAILS_SANITIZE_LEAK=true
>   . ./lib-git-svn.sh
>   
>   test_expect_success 'setup propset via import' '
> diff --git a/t/t9151-svn-mergeinfo.sh b/t/t9151-svn-mergeinfo.sh
> index c93a5beab25..85221d439bd 100755
> --- a/t/t9151-svn-mergeinfo.sh
> +++ b/t/t9151-svn-mergeinfo.sh
> @@ -5,6 +5,7 @@
>   
>   test_description='git-svn svn mergeinfo properties'
>   
> +TEST_FAILS_SANITIZE_LEAK=true
>   . ./lib-git-svn.sh
>   
>   test_expect_success 'load svn dump' "
> diff --git a/t/t9160-git-svn-preserve-empty-dirs.sh b/t/t9160-git-svn-preserve-empty-dirs.sh
> index 36c6b1a12ff..9cf7a1427ab 100755
> --- a/t/t9160-git-svn-preserve-empty-dirs.sh
> +++ b/t/t9160-git-svn-preserve-empty-dirs.sh
> @@ -9,6 +9,7 @@ This test uses git to clone a Subversion repository that contains empty
>   directories, and checks that corresponding directories are created in the
>   local Git repository with placeholder files.'
>   
> +TEST_FAILS_SANITIZE_LEAK=true
>   . ./lib-git-svn.sh
>   
>   GIT_REPO=git-svn-repo
> diff --git a/t/t9162-git-svn-dcommit-interactive.sh b/t/t9162-git-svn-dcommit-interactive.sh
> index e38d9fa37b5..e2aa8ed88a9 100755
> --- a/t/t9162-git-svn-dcommit-interactive.sh
> +++ b/t/t9162-git-svn-dcommit-interactive.sh
> @@ -3,6 +3,8 @@
>   # Copyright (c) 2011 Frédéric Heitzmann
>   
>   test_description='git svn dcommit --interactive series'
> +
> +TEST_FAILS_SANITIZE_LEAK=true
>   . ./lib-git-svn.sh
>   
>   test_expect_success 'initialize repo' '
> diff --git a/t/t9164-git-svn-dcommit-concurrent.sh b/t/t9164-git-svn-dcommit-concurrent.sh
> index 8466269bf50..1465156072e 100755
> --- a/t/t9164-git-svn-dcommit-concurrent.sh
> +++ b/t/t9164-git-svn-dcommit-concurrent.sh
> @@ -4,6 +4,8 @@
>   #
>   
>   test_description='concurrent git svn dcommit'
> +
> +TEST_FAILS_SANITIZE_LEAK=true
>   . ./lib-git-svn.sh
>   
>   
> diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-standalone-http-status.sh
> index 32814e75df5..c900231079c 100755
> --- a/t/t9501-gitweb-standalone-http-status.sh
> +++ b/t/t9501-gitweb-standalone-http-status.sh
> @@ -13,6 +13,7 @@ code and message.'
>   GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>   export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>   
> +TEST_PASSES_SANITIZE_LEAK=true
>   . ./lib-gitweb.sh
>   
>   #
