Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A854FECAAA1
	for <git@archiver.kernel.org>; Tue,  6 Sep 2022 06:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238620AbiIFGt1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Sep 2022 02:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238631AbiIFGtZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2022 02:49:25 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C9E71BEE
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 23:49:19 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id x1so6023638plv.5
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 23:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:subject:to:from:sender:from
         :to:cc:subject:date;
        bh=Q+VH97aZYx2uwfQ7mFZ5Vx3oNkUJ5lDJJRmcXVbpCs8=;
        b=dba0Yiq3dNfdfc5r39ciVrVi7Od/YwVv63SPpK+2OKnuqoqFHHyMhhEolOalLZo8//
         tPQh4UGx2P/d+OZLb4Ma4D6bt6bZ0+8raJnSMSpQTLPT6n7RCTkMxh1Q90a/S8a5fXNS
         rySQM57AdaxQEtnLMq5Watgl8acN+yctlw5ijT5aqgFvQnuxF6R5yqIzLGNdWUp0NjZT
         jusf0r85CCoLiqWSU7KW/H0SmJTqapOR4kgfeX0vKn7NQMMJRZh3CuVB2j9QWRZS/2sy
         PnQjERAcvjxN4oS9cwV3azmLLUJ5G3faX4frE2thpwp2qxacYrIy/Ra8FtKW4x2UlsOV
         6imA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:subject:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Q+VH97aZYx2uwfQ7mFZ5Vx3oNkUJ5lDJJRmcXVbpCs8=;
        b=IlIzVsGlh1WVQT6Lea5xoUC5N0GnHEtT7xcM9zN6VZzAqbNGgtTlE3HTR/on7wdkKo
         G/Am3XvMM63XAlwM77zC5KKxfIlpG4r0ZGJ6Rz5D3snrtELpC2iFekMIOtnrOuMjnH+Y
         DM4imcXpNrvvK+HkiqzilAlTLMrQQmvBvw2F5Etc8vxZFLRutXvVMaYdcL8bL9whClqz
         /jn51t3tjNFVfbNSi+Lr4wtIqwx9K6IxPqEnoblY8x5Brh08OwL4gNU4DmnHCY0k6yyt
         xr+VOJpln5GsNpfibIr5o0u463TFR+HMMygVI4DY9FLCogN2KysxvuNpVtUiDt/R36dL
         5NWA==
X-Gm-Message-State: ACgBeo20TrT6Cpk/p2Kq+u7g8LJwou4Y/ARAM3PtjGLpp6qQnQHx0AzX
        r0aWKwLeTs7Jt+NQpZ5OR1gHwH57fDA=
X-Google-Smtp-Source: AA6agR4pY0OuB8pU8cs/8g/NK51XiX5mLiUkbtsH1DPocB/YUKLA/8vcg99ovrDjSeJL+YQyCWsX7g==
X-Received: by 2002:a17:902:6ac8:b0:175:44b5:5264 with SMTP id i8-20020a1709026ac800b0017544b55264mr29515794plt.19.1662446958299;
        Mon, 05 Sep 2022 23:49:18 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902d2ca00b0017515e598c5sm2867820plc.40.2022.09.05.23.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 23:49:17 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Sep 2022, #01; Mon, 5)
X-master-at: 79f2338b3746d23454308648b2491e5beba4beff
X-next-at: 6a6ce2da067c0f93245427725e5f14352452ea04
Date:   Mon, 05 Sep 2022 23:49:17 -0700
Message-ID: <xmqqilm1yp3m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking in my tree.  Commits
prefixed with '+' are in 'next' (being in 'next' is a sign that a
topic is stable enough to be used and are candidate to be in a future
release).  Commits prefixed with '-' are only in 'seen', and aren't
considered "accepted" at all.  A topic without enough support may be
discarded after a long period of no activity.

We just started week #9 in a 12-week cycle toward Git 2.38
(tinyurl.com/gitCal), but since Monday was a holiday in US, we may
see only four days worth of new patches, which is less work for our
reviewers pool ;-)

Copies of the source code to Git live in many repositories, and the
following is a list of the ones I push into or their mirrors.  Some
repositories have only a subset of branches.

With maint, master, next, seen, todo:

	git://git.kernel.org/pub/scm/git/git.git/
	git://repo.or.cz/alt-git.git/
	https://kernel.googlesource.com/pub/scm/git/git/
	https://github.com/git/git/
	https://gitlab.com/git-vcs/git/

With all the integration branches and topics broken out:

	https://github.com/gitster/git/

Even though the preformatted documentation in HTML and man format
are not sources, they are published in these repositories for
convenience (replace "htmldocs" with "manpages" for the manual
pages):

	git://git.kernel.org/pub/scm/git/git-htmldocs.git/
	https://github.com/gitster/git-htmldocs.git/

Release tarballs are available at:

	https://www.kernel.org/pub/software/scm/git/

--------------------------------------------------
[Graduated to 'master']

* ac/bitmap-lookup-table (2022-08-28) 7 commits
  (merged to 'next' on 2022-08-29 at 05d2d2c8bd)
 + pack-bitmap-write: drop unused pack_idx_entry parameters
  (merged to 'next' on 2022-08-26 at 7914c141eb)
 + bitmap-lookup-table: add performance tests for lookup table
 + pack-bitmap: prepare to read lookup table extension
 + pack-bitmap-write: learn pack.writeBitmapLookupTable and add tests
 + pack-bitmap-write.c: write lookup table extension
 + bitmap: move `get commit positions` code to `bitmap_writer_finish`
 + Documentation/technical: describe bitmap lookup table extension

 The pack bitmap file gained a bitmap-lookup table to speed up
 locating the necessary bitmap for a given commit.
 source: <pull.1266.v6.git.1660496112.gitgitgadget@gmail.com>


* bc/gc-crontab-fix (2022-08-28) 1 commit
  (merged to 'next' on 2022-08-30 at a7a240a4da)
 + gc: use temporary file for editing crontab
 (this branch is used by jk/test-crontab-fixes.)

 FreeBSD portability fix for "git maintenance" that spawns "crontab"
 to schedule tasks.
 source: <20220828214143.754759-1-sandals@crustytoothpaste.net>


* ds/bundle-uri-clone (2022-08-24) 6 commits
  (merged to 'next' on 2022-08-25 at 14754922fa)
 + clone: warn on failure to repo_init()
  (merged to 'next' on 2022-08-18 at 5e8a3ec71e)
 + clone: --bundle-uri cannot be combined with --depth
 + bundle-uri: add support for http(s):// and file://
 + clone: add --bundle-uri option
 + bundle-uri: create basic file-copy logic
 + remote-curl: add 'get' capability
 (this branch is used by ds/bundle-uri-3.)

 Implement "git clone --bundle-uri".
 source: <pull.1300.v3.git.1660050703.gitgitgadget@gmail.com>
 source: <5229519b-3af2-a023-8996-43343b130722@github.com>


* en/merge-multi-strategies (2022-08-24) 2 commits
  (merged to 'next' on 2022-08-25 at 420e2eae66)
 + merge: small code readability improvement
 + merge: cleanup confusing logic for handling successful merges

 The code that implements multi-strategy support in "git merge" has
 been clean-up a bit.
 source: <pull.1331.v2.git.1661222541.gitgitgadget@gmail.com>


* en/merge-unstash-only-on-clean-merge (2022-08-24) 1 commit
  (merged to 'next' on 2022-08-25 at a144bdf6cb)
 + merge: only apply autostash when appropriate

 The auto-stashed local changes created by "git merge --autostash"
 was mixed into a conflicted state left in the working tree, which
 has been corrected.
 source: <610b8d089db97bf1a37dbf230f51ecafe3086254.1661222541.git.gitgitgadget@gmail.com>


* en/t4301-more-merge-tree-tests (2022-08-24) 1 commit
  (merged to 'next' on 2022-08-25 at c7abf60ff4)
 + t4301: add more interesting merge-tree testcases
 (this branch is used by es/t4301-sed-portability-fix.)

 More tests to protect the current behaviour of "merge-tree" before
 it gets further updated.
 source: <pull.1332.git.1661237316150.gitgitgadget@gmail.com>


* en/test-without-test-create-repo (2022-08-26) 1 commit
  (merged to 'next' on 2022-08-30 at 4f80f48e27)
 + t64xx: convert 'test_create_repo' to 'git init'

 Test clean-up.
 source: <pull.1303.v2.git.git.1661485759789.gitgitgadget@gmail.com>


* es/t4301-sed-portability-fix (2022-08-29) 4 commits
  (merged to 'next' on 2022-08-30 at eec0ceef0a)
 + t4301: emit blank line in more idiomatic fashion
 + t4301: fix broken &&-chains and add missing loop termination
 + t4301: account for behavior differences between sed implementations
 + Merge branch 'en/t4301-more-merge-tree-tests' into es/t4301-sed-portability-fix

 Test clean-up.
 source: <pull.1339.git.1661663879.gitgitgadget@gmail.com>


* jk/test-crontab-fixes (2022-08-30) 1 commit
  (merged to 'next' on 2022-09-02 at d5113b5be3)
 + test-crontab: minor memory and error handling fixes
 (this branch uses bc/gc-crontab-fix.)

 Test helper fix.
 source: <20220823010120.25388-1-sandals@crustytoothpaste.net>


* rs/tempfile-cleanup-race-fix (2022-08-27) 1 commit
  (merged to 'next' on 2022-08-30 at 158dd1c910)
 + tempfile: avoid directory cleanup race
 (this branch is used by jk/tempfile-active-flag-cleanup.)

 The clean-up of temporary files created via mks_tempfile_dt() was
 racy and attempted to unlink() the leading directory when signals
 are involved, which has been corrected.
 source: <526a174e-b179-c284-a21c-7afe0a0b4df2@web.de>


* rs/test-mergesort (2022-08-28) 2 commits
  (merged to 'next' on 2022-08-30 at 4905149886)
 + test-mergesort: use mem_pool for sort input
 + test-mergesort: read sort input all at once

 Optimization of a test-helper command.
 source: <128f0fb8-d29b-8622-0cfe-2ecadc999db5@web.de>


* sg/parse-options-subcommand (2022-08-25) 23 commits
  (merged to 'next' on 2022-08-25 at dab6bf1439)
 + remote: run "remote rm" argv through parse_options()
 + maintenance: add parse-options boilerplate for subcommands
 + pass subcommand "prefix" arguments to parse_options()
  (merged to 'next' on 2022-08-22 at 09d07c2271)
 + builtin/worktree.c: let parse-options parse subcommands
 + builtin/stash.c: let parse-options parse subcommands
 + builtin/sparse-checkout.c: let parse-options parse subcommands
 + builtin/remote.c: let parse-options parse subcommands
 + builtin/reflog.c: let parse-options parse subcommands
 + builtin/notes.c: let parse-options parse subcommands
 + builtin/multi-pack-index.c: let parse-options parse subcommands
 + builtin/hook.c: let parse-options parse subcommands
 + builtin/gc.c: let parse-options parse 'git maintenance's subcommands
 + builtin/commit-graph.c: let parse-options parse subcommands
 + builtin/bundle.c: let parse-options parse subcommands
 + parse-options: add support for parsing subcommands
 + parse-options: drop leading space from '--git-completion-helper' output
 + parse-options: clarify the limitations of PARSE_OPT_NODASH
 + parse-options: PARSE_OPT_KEEP_UNKNOWN only applies to --options
 + api-parse-options.txt: fix description of OPT_CMDMODE
 + t0040-parse-options: test parse_options() with various 'parse_opt_flags'
 + t5505-remote.sh: check the behavior without a subcommand
 + t3301-notes.sh: check that default operation mode doesn't take arguments
 + git.c: update NO_PARSEOPT markings
 (this branch is used by js/bisect-in-c.)

 Introduce the "subcommand" mode to parse-options API and update the
 command line parser of Git commands with subcommands.
 source: <20220819160411.1791200-1-szeder.dev@gmail.com>
 source: <YwdSzrF3xaHvLsI+@coredump.intra.peff.net>


* tb/midx-with-changing-preferred-pack-fix (2022-08-22) 7 commits
  (merged to 'next' on 2022-08-26 at 305a9d3323)
 + midx.c: avoid adding preferred objects twice
 + midx.c: include preferred pack correctly with existing MIDX
 + midx.c: extract `midx_fanout_add_pack_fanout()`
 + midx.c: extract `midx_fanout_add_midx_fanout()`
 + midx.c: extract `struct midx_fanout`
 + t/lib-bitmap.sh: avoid silencing stderr
 + t5326: demonstrate potential bitmap corruption

 Multi-pack index got corrupted when preferred pack changed from one
 pack to another in a certain way, which has been corrected.
 source: <cover.1661197803.git.me@ttaylorr.com>



--------------------------------------------------
[Stalled]

* es/mark-gc-cruft-as-experimental (2022-08-03) 2 commits
 - config: let feature.experimental imply gc.cruftPacks=true
 - gc: add tests for --cruft and friends

 Enable gc.cruftpacks by default for those who opt into
 feature.experimental setting.

 Expecting a reroll.
 cf. <220804.86a68ke9d5.gmgdl@evledraar.gmail.com>
 cf. <6803b725-526e-a1c8-f15c-a9ed4a144d4c@github.com>
 source: <20220803205721.3686361-1-emilyshaffer@google.com>


* es/doc-creation-factor-fix (2022-07-28) 2 commits
 - range-diff: clarify --creation-factor=<factor>
 - format-patch: clarify --creation-factor=<factor>

 Expecting a reroll by somebody more familiar with the logic
 cf. <xmqqo7wfix7p.fsf@gitster.g>
 source: <7229p500-p2r4-on87-6802-8o90s36rr3s4@tzk.qr>


* cw/remote-object-info (2022-08-13) 7 commits
 - SQUASH???
 - cat-file: add remote-object-info to batch-command
 - transport: add client support for object-info
 - serve: advertise object-info feature
 - protocol-caps: initialization bug fix
 - fetch-pack: move fetch initialization
 - fetch-pack: refactor packet writing

 A client component to talk with the object-info endpoint.

 Expecting a reroll.
 cf. <20220728230210.2952731-1-calvinwan@google.com>
 cf. <CAFySSZDvgwbbHCHfyuaqX3tKsr-GjJ9iihygg6rNNe46Ys7_EA@mail.gmail.com>
 source: <20220728230210.2952731-1-calvinwan@google.com>




--------------------------------------------------
[New Topics]

* ab/unused-annotation (2022-09-01) 2 commits
 - git-compat-util.h: use "deprecated" for UNUSED variables
 - git-compat-util.h: use "UNUSED", not "UNUSED(var)"
 (this branch uses jk/unused-annotation.)

 Undoes 'jk/unused-annotation' topic and redoes it to work around
 Coccinelle rules misfiring false positives in unrelated codepaths.

 Will merge to 'next'?
 source: <cover-0.2-00000000000-20220825T170709Z-avarab@gmail.com>


* ab/coccicheck-incremental (2022-08-31) 9 commits
 - spatchcache: add a ccache-alike for "spatch"
 - cocci: optimistically use COMPUTE_HEADER_DEPENDENCIES
 - cocci: make "coccicheck" rule incremental
 - cocci: split off "--all-includes" from SPATCH_FLAGS
 - cocci: split off include-less "tests" from SPATCH_FLAGS
 - Makefile: split off SPATCH_BATCH_SIZE comment from "cocci" heading
 - Makefile: have "coccicheck" re-run if flags change
 - Makefile: add ability to TAB-complete cocci *.patch rules
 - cocci rules: remove unused "F" metavariable from pending rule

 source: <cover-v2-0.9-00000000000-20220831T205130Z-avarab@gmail.com>


* ab/retire-ppc-sha1 (2022-08-31) 2 commits
  (merged to 'next' on 2022-09-05 at 480da6ef06)
 + Makefile: use $(OBJECTS) instead of $(C_OBJ)
 + Makefile + hash.h: remove PPC_SHA1 implementation

 Remove the assembly version of SHA-1 implementation for PPC.

 Will merge to 'master'.
 source: <cover-v3-0.2-00000000000-20220831T090744Z-avarab@gmail.com>


* en/remerge-diff-fixes (2022-09-02) 3 commits
 - diff: fix filtering of merge commits under --remerge-diff
 - diff: fix filtering of additional headers under --remerge-diff
 - diff: have submodule_format logic avoid additional diff headers

 Fix a few "git log --remerge-diff" bugs.

 Will probably need to rebase to make it mergeable to 'maint'.
 source: <pull.1342.v3.git.1662090810.gitgitgadget@gmail.com>


* es/chainlint (2022-09-01) 18 commits
 - t: retire unused chainlint.sed
 - t/Makefile: teach `make test` and `make prove` to run chainlint.pl
 - test-lib: replace chainlint.sed with chainlint.pl
 - test-lib: retire "lint harder" optimization hack
 - t/chainlint: add more chainlint.pl self-tests
 - chainlint.pl: allow `|| echo` to signal failure upstream of a pipe
 - chainlint.pl: complain about loops lacking explicit failure handling
 - chainlint.pl: don't flag broken &&-chain if failure indicated explicitly
 - chainlint.pl: don't flag broken &&-chain if `$?` handled explicitly
 - chainlint.pl: don't require `&` background command to end with `&&`
 - t/Makefile: apply chainlint.pl to existing self-tests
 - chainlint.pl: don't require `return|exit|continue` to end with `&&`
 - chainlint.pl: validate test scripts in parallel
 - chainlint.pl: add parser to identify test definitions
 - chainlint.pl: add parser to validate tests
 - chainlint.pl: add POSIX shell parser
 - chainlint.pl: add POSIX shell lexical analyzer
 - t: add skeleton chainlint.pl

 Revamp chainlint script for our tests.
 source: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>


* jk/tempfile-active-flag-cleanup (2022-08-30) 3 commits
  (merged to 'next' on 2022-09-05 at 43ed4656b3)
 + tempfile: update comment describing state transitions
 + tempfile: drop active flag
 + Merge branch 'rs/tempfile-cleanup-race-fix' into jk/tempfile-active-flag-cleanup

 Code clean-up.

 Will merge to 'master'.
 source: <Yw5nmNJSm9uzLOKL@coredump.intra.peff.net>


* vd/scalar-to-main (2022-09-02) 9 commits
 - Documentation/technical: include Scalar technical doc
 - t/perf: add 'GIT_PERF_USE_SCALAR' run option
 - t/perf: add Scalar performance tests
 - scalar-clone: add test coverage
 - scalar: add to 'git help -a' command list
 - scalar: implement the `help` subcommand
 - git help: special-case `scalar`
 - scalar: include in standard Git build & installation
 - scalar: fix command documentation section header

 Hoist the remainder of "scalar" out of contrib/ to the main part of
 the codebase.
 source: <pull.1341.v2.git.1662134210.gitgitgadget@gmail.com>


* ad/t1800-cygwin (2022-09-01) 1 commit
 - t1800: correct test to handle Cygwin

 Test fix.

 Expecting a reroll.
 cf. <YxFinAJ2NeKiHaS8@danh.dev>
 source: <20220901173942.abolcr4aa5gixncm@lucy.dinwoodie.org>


* jc/diff-no-index-unleak (2022-09-02) 1 commit
 - diff --no-index: unleak paths[] elements

 Plug a leak or two in "git diff --no-index".
 source: <xmqqilm579hc.fsf@gitster.g>


* ow/rev-parse-parseopt-fix (2022-09-02) 1 commit
 - rev-parse --parseopt: detect missing opt-spec

 The parser in the script interface to parse-options in "git
 rev-parse" has been updated to diagnose a bogus input correctly.

 Will merge to 'next'?
 source: <20220902175902.22346-1-oystwa@gmail.com>


* vd/sparse-reset-checkout-fixes (2022-09-02) 1 commit
  (merged to 'next' on 2022-09-05 at 8c59ace003)
 + unpack-trees: fix sparse directory recursion check

 Segfault fix-up to an earlier fix to the topic to teach "git reset"
 and "git checkout" work better in a sparse checkout.

 Will merge to 'master'.
 source: <pull.1344.git.1662066153644.gitgitgadget@gmail.com>

--------------------------------------------------
[Cooking]

* tb/diffstat-with-utf8-strwidth (2022-08-27) 1 commit
 - diff.c: use utf8_strwidth() when appropriate

 "git diff --stat" etc. were invented back when everything was ASCII
 and strlen() was a way to measure the display width of a string;
 adjust them to compute the display width assuming UTF-8 pathnames.
 source: <20220827085007.20030-1-tboegi@web.de>


* gc/submodule-propagate-branches (2022-08-29) 6 commits
 - clone, submodule update: check out branches
 - submodule--helper: refactor up-to-date criterion
 - submodule: return target of submodule symref
 - t5617: drop references to remote-tracking branches
 - repo-settings: add submodule_propagate_branches
 - clone: teach --detach option

 "git clone --recurse-submodules" and "git submodule update" learns
 to honor the "propagete branches" option.

 Needs review.
 source: <pull.1321.git.git.1661806456.gitgitgadget@gmail.com>


* jc/format-patch-force-in-body-from (2022-08-29) 3 commits
  (merged to 'next' on 2022-09-05 at cecaaad60e)
 + format-patch: learn format.forceInBodyFrom configuration variable
 + format-patch: allow forcing the use of in-body From: header
 + pretty: separate out the logic to decide the use of in-body from

 "git format-patch --from=<ident>" can be told to add an in-body
 "From:" line even for commits that are authored by the given
 <ident> with "--force-in-body-from"option.

 Will merge to 'master'.
 source: <20220829213837.13849-1-gitster@pobox.com>


* sy/sparse-grep (2022-09-02) 3 commits
 - builtin/grep.c: walking tree instead of expanding index with --sparse
 - builtin/grep.c: integrate with sparse index
 - builtin/grep.c: add --sparse option

 source: <20220903003623.64750-1-shaoxuan.yuan02@gmail.com>


* cc/doc-trailer-whitespace-rules (2022-08-30) 1 commit
  (merged to 'next' on 2022-09-05 at 4c018a3ab7)
 + Documentation: clarify whitespace rules for trailers

 Doc update.

 Will merge to 'master'.
 source: <20220830105046.324041-1-christian.couder@gmail.com>


* js/builtin-add-p-portability-fix (2022-08-30) 3 commits
 - t6132(NO_PERL): do not run the scripted `add -p`
 - t3701: test the built-in `add -i` regardless of NO_PERL
 - add -p: avoid ambiguous signed/unsigned comparison

 More fixes to "add -p"

 Will merge to 'next'?
 source: <pull.1340.git.1661867664.gitgitgadget@gmail.com>


* ds/use-platform-regex-on-macos (2022-08-26) 1 commit
 - grep: fix multibyte regex handling under macOS

 With a bit of header twiddling, use the native regexp library on
 macOS instead of the compat/ one.

 Needs review.
 source: <20220826085815.2771102-1-dds@aueb.gr>


* ds/bundle-uri-3 (2022-08-24) 8 commits
 - bundle-uri: fetch a list of bundles
 - bundle-uri: limit recursion depth for bundle lists
 - bundle-uri: parse bundle list in config format
 - bundle-uri: unit test "key=value" parsing
 - bundle-uri: create "key=value" line parsing
 - bundle-uri: create base key-value pair parsing
 - bundle-uri: create bundle_list struct and helpers
 - Merge branch 'ds/bundle-uri-clone' into ds/bundle-uri-3

 Define the logical elements of a "bundle list", data structure to
 store them in-core, format to transfer them, and code to parse
 them.

 Needs review.
 source: <pull.1333.git.1661181174.gitgitgadget@gmail.com>


* js/add-p-diff-parsing-fix (2022-09-01) 3 commits
  (merged to 'next' on 2022-09-02 at 1545e0898d)
 + add -p: ignore dirty submodules
 + add -p: gracefully handle unparseable hunk headers in colored diffs
 + add -p: detect more mismatches between plain vs colored diffs

 Those who use diff-so-fancy as the diff-filter noticed a regression
 or two in the code that parses the diff output in the built-in
 version of "add -p", which has been corrected.

 Will merge to 'master'.
 source: <pull.1336.v5.git.1662046939.gitgitgadget@gmail.com>


* js/cmake-updates (2022-08-24) 5 commits
 - cmake: increase time-out for a long-running test
 - cmake: avoid editing t/test-lib.sh
 - add -p: avoid ambiguous signed/unsigned comparison
 - cmake: copy the merge tools for testing
 - cmake: make it easier to diagnose regressions in CTest runs

 Update to build procedure with VS using CMake/CTest.

 Needs review.
 source: <pull.1320.v2.git.1661243463.gitgitgadget@gmail.com>


* js/range-diff-with-pathspec (2022-08-26) 3 commits
  (merged to 'next' on 2022-09-05 at c027222552)
 + range-diff: optionally accept pathspecs
 + range-diff: consistently validate the arguments
 + range-diff: reorder argument handling

 Allow passing a pathspec to "git range-diff".

 Will merge to 'master'.
 source: <pull.1335.v2.git.1661506770.gitgitgadget@gmail.com>


* jk/unused-annotation (2022-08-19) 11 commits
  (merged to 'next' on 2022-08-24 at 2174b8c75d)
 + is_path_owned_by_current_uid(): mark "report" parameter as unused
 + run-command: mark unused async callback parameters
 + mark unused read_tree_recursive() callback parameters
 + hashmap: mark unused callback parameters
 + config: mark unused callback parameters
 + streaming: mark unused virtual method parameters
 + transport: mark bundle transport_options as unused
 + refs: mark unused virtual method parameters
 + refs: mark unused reflog callback parameters
 + refs: mark unused each_ref_fn parameters
 + git-compat-util: add UNUSED macro
 (this branch is used by ab/unused-annotation.)

 Annotate function parameters that are not used (but cannot be
 removed for structural reasons), to prepare us to later compile
 with -Wunused warning turned on.

 Will keep but 'ab/unused-annotation' will undo/redo the whole thing.
 cf. <Ywh7ppVFk6VK1Ybs@coredump.intra.peff.net>
 cf. <xmqqy1v7r3so.fsf@gitster.g>
 source: <Yv9gxqH6nK2KYnNj@coredump.intra.peff.net>


* ed/fsmonitor-on-network-disk (2022-08-31) 5 commits
 - fsmonitor: normalize FSEvents event paths to the real path
 - fsmonitor: ensure filesystem and unix socket filesystem are compatible
 - fsmonitor: generate unique Unix socket file name in the desired location
 - fsmonitor: add two new config options, allowRemote and socketDir
  (merged to 'next' on 2022-08-14 at 637d458d9c)
 + fsmonitor: option to allow fsmonitor to run against network-mounted repos

 The built-in fsmonitor refuses to work on a network mounted
 repositories; a configuration knob for users to override this has
 been introduced.

 Needs review.
 source: <pull.1317.v3.git.1660242752495.gitgitgadget@gmail.com>
 source: <pull.1326.v4.git.1661962145.gitgitgadget@gmail.com>


* pw/rebase-keep-base-fixes (2022-08-18) 5 commits
 - rebase --keep-base: imply --no-fork-point
 - rebase --keep-base: imply --reapply-cherry-picks
 - rebase: factor out merge_base calculation
 - rebase: store orig_head as a commit
 - t3416: set $EDITOR in subshell

 "git rebase --keep-base" used to discard the commits that are
 already cherry-picked to the upstream, even when "keep-base" meant
 that the base, on top of which the history is being rebuilt, does
 not yet include these cherry-picked commits.  The --keep-base
 option now implies --reapply-cherry-picks and --no-fork-point
 options.

 Expecting a reroll.
 cf. <eab55cef-62bd-af2b-c295-1e76beca032f@gmail.com>
 source: <pull.1323.git.1660576283.gitgitgadget@gmail.com>


* ag/merge-strategies-in-c (2022-08-10) 14 commits
 - sequencer: use the "octopus" strategy without forking
 - sequencer: use the "resolve" strategy without forking
 - merge: use the "octopus" strategy without forking
 - merge: use the "resolve" strategy without forking
 - merge-octopus: rewrite in C
 - merge-recursive: move better_branch_name() to merge.c
 - merge-resolve: rewrite in C
 - merge-one-file: rewrite in C
 - update-index: move add_cacheinfo() to read-cache.c
 - merge-index: add a new way to invoke `git-merge-one-file'
 - merge-index: drop the index
 - merge-index: libify merge_one_path() and merge_all()
 - t6060: add tests for removed files
 - t6060: modify multiple files to expose a possible issue with merge-index

 An attempt to rewrite remaining merge strategies from shell to C.

 Needs more work.
 At the minimum, we should lose 11/14 and possibly 08/14.
 cf. <xmqq7d36vfur.fsf@gitster.g>
 source: <20220809185429.20098-1-alban.gruin@gmail.com>


* sy/mv-out-of-cone (2022-08-10) 9 commits
  (merged to 'next' on 2022-08-17 at 2316d9ce4d)
 + mv: check overwrite for in-to-out move
 + advice.h: add advise_on_moving_dirty_path()
 + mv: cleanup empty WORKING_DIRECTORY
 + mv: from in-cone to out-of-cone
 + mv: remove BOTH from enum update_mode
 + mv: check if <destination> is a SKIP_WORKTREE_DIR
 + mv: free the with_slash in check_dir_in_index()
 + mv: rename check_dir_in_index() to empty_dir_has_sparse_contents()
 + t7002: add tests for moving from in-cone to out-of-cone

 "git mv A B" in a sparsely populated working tree can be asked to
 move a path from a directory that is "in cone" to another directory
 that is "out of cone".  Handling of such a case has been improved.

 An oob read access makes sanitizer build segfault.
 cf.<YwdJRRuST2SP8ZT7@coredump.intra.peff.net>
 source: <20220809120910.2021413-1-shaoxuan.yuan02@gmail.com>


* ab/submodule-helper-prep (2022-09-02) 33 commits
  (merged to 'next' on 2022-09-05 at b0d1b6ada7)
 + submodule--helper: fix bad config API usage
 + submodule--helper: libify even more "die" paths for module_update()
 + submodule--helper: libify more "die" paths for module_update()
 + submodule--helper: check repo{_submodule,}_init() return values
 + submodule--helper: libify "must_die_on_failure" code paths (for die)
 + submodule--helper update: don't override 'checkout' exit code
 + submodule--helper: libify "must_die_on_failure" code paths
 + submodule--helper: libify determine_submodule_update_strategy()
 + submodule--helper: don't exit() on failure, return
 + submodule--helper: use "code" in run_update_command()
 + submodule API: don't handle SM_..{UNSPECIFIED,COMMAND} in to_string()
 + submodule--helper: don't call submodule_strategy_to_string() in BUG()
 + submodule--helper: add missing braces to "else" arm
 + submodule--helper: return "ret", not "1" from update_submodule()
 + submodule--helper: rename "int res" to "int ret"
 + submodule--helper: don't redundantly check "else if (res)"
 + submodule--helper: refactor "errmsg_str" to be a "struct strbuf"
 + submodule--helper: add "const" to passed "struct update_data"
 + submodule--helper: add "const" to copy of "update_data"
 + submodule--helper: add "const" to passed "module_clone_data"
 + submodule--helper: move "sb" in clone_submodule() to its own scope
 + submodule--helper: use xstrfmt() in clone_submodule()
 + submodule--helper: replace memset() with { 0 }-initialization
 + submodule--helper style: add \n\n after variable declarations
 + submodule--helper style: don't separate declared variables with \n\n
 + submodule--helper: move "resolve-relative-url-test" to a test-tool
 + submodule--helper: move "check-name" to a test-tool
 + submodule--helper: move "is-active" to a test-tool
 + test-tool submodule-config: remove unused "--url" handling
 + submodule--helper: remove unused "list" helper
 + submodule--helper: remove unused "name" helper
 + submodule tests: test for "add <repository> <abs-path>"
 + submodule tests: test usage behavior
 (this branch is used by ab/submodule-helper-leakfix.)

 Code clean-up of "git submodule--helper".

 Will merge to 'master'.
 source: <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>


* ab/dedup-config-and-command-docs (2022-08-31) 9 commits
 - docs: add CONFIGURATION sections that fuzzy map to built-ins
 - docs: add CONFIGURATION sections that map to a built-in
 - log docs: de-duplicate configuration sections
 - difftool docs: de-duplicate configuration sections
 - notes docs: de-duplicate and combine configuration sections
 - apply docs: de-duplicate configuration sections
 - send-email docs: de-duplicate configuration sections
 - grep docs: de-duplicate configuration sections
 - docs: add and use include template for config/* includes

 Share the text used to explain configuration variables used by "git
 <subcmd>" in "git help <subcmd>" with the text from "git help config".
 source: <cover-v3-0.9-00000000000-20220831T083759Z-avarab@gmail.com>


* ab/submodule-helper-leakfix (2022-09-02) 18 commits
 - submodule--helper: fix a configure_added_submodule() leak
 - submodule--helper: free rest of "displaypath" in "struct update_data"
 - submodule--helper: free some "displaypath" in "struct update_data"
 - submodule--helper: fix a memory leak in print_status()
 - submodule--helper: fix a leak in module_add()
 - submodule--helper: fix obscure leak in module_add()
 - submodule--helper: fix "reference" leak
 - submodule--helper: fix a memory leak in get_default_remote_submodule()
 - submodule--helper: fix a leak with repo_clear()
 - submodule--helper: fix "sm_path" and other "module_cb_list" leaks
 - submodule--helper: fix "errmsg_str" memory leak
 - submodule--helper: add and use *_release() functions
 - submodule--helper: don't leak {run,capture}_command() cp.dir argument
 - submodule--helper: "struct pathspec" memory leak in module_update()
 - submodule--helper: fix most "struct pathspec" memory leaks
 - submodule--helper: fix trivial get_default_remote_submodule() leak
 - submodule--helper: fix a leak in "clone_submodule"
 - Merge branch 'ab/submodule-helper-prep' into ab/submodule-helper-leakfix
 (this branch uses ab/submodule-helper-prep.)

 Plugging leaks in submodule--helper.

 Will merge to 'next'?
 source: <cover-v7-00.17-00000000000-20220831T231003Z-avarab@gmail.com>


* po/glossary-around-traversal (2022-07-09) 3 commits
 - glossary: add reachability bitmap description
 - glossary: add commit graph description
 - glossary: add Object DataBase (ODB) abbreviation

 The glossary entries for "commit-graph file" and "reachability
 bitmap" have been added.

 Expecting a reroll.
 cf. <dfe0c1ab-33f8-f13e-71ce-1829bb0d2d7f@iee.email>
 source: <pull.1282.git.1657385781.gitgitgadget@gmail.com>


* js/bisect-in-c (2022-08-30) 17 commits
 - bisect: no longer try to clean up left-over `.git/head-name` files
 - bisect: remove Cogito-related code
 - Turn `git bisect` into a full built-in
 - bisect: move even the command-line parsing to `bisect--helper`
 - bisect--helper: make `state` optional
 - bisect--helper: calling `bisect_state()` without an argument is a bug
 - bisect: avoid double-quoting when printing the failed command
 - bisect run: fix the error message
 - bisect: verify that a bogus option won't try to start a bisection
 - bisect--helper: migrate to OPT_SUBCOMMAND()
 - bisect--helper: make the order consistently `argc, argv`
 - bisect--helper: make `terms` an explicit singleton
 - bisect--helper: simplify exit code computation
 - bisect--helper: really retire `--bisect-autostart`
 - bisect--helper: really retire --bisect-next-check
 - bisect--helper: retire the --no-log option
 - Merge branch 'sg/parse-options-subcommand' into js/bisect-in-c

 Final bits of "git bisect.sh" have been rewritten in C.
 source: <pull.1132.v6.git.1661885419.gitgitgadget@gmail.com>
