Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14047C433F5
	for <git@archiver.kernel.org>; Sat, 19 Mar 2022 09:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242547AbiCSJNP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Mar 2022 05:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiCSJNO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Mar 2022 05:13:14 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B761A8E1B4
        for <git@vger.kernel.org>; Sat, 19 Mar 2022 02:11:52 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 1AFB03200F9C;
        Sat, 19 Mar 2022 05:11:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 19 Mar 2022 05:11:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; bh=G47exBtKPU+yfFjJPgk5dM+ArvXS8AuS8jtMy5lW7d0=; b=fqUn2
        DnzeTGxuC9sY3cP8o19aS+Rep4C35q6B84K2qtdFMiP7fQOkRsYVkYZRgfLydYTG
        G+NpAkMl2imcq1LHXNzl8IYcgyX2RraMDRcI61HkdBoUbtL+etQ51CpPgRm0tH2l
        x7+ePMlUWRv0pMQbrfr7/RF7+M25XLX6docADA/GkPT62tpPJnk9RiOAFCa20pKV
        rUPk9QrZjPFwsQGSZ3i3nz/ncpVkIanWO9CMed6kJSUHybuRWbKWcn9mYiuJdj55
        sJ/21pjb77FK0h1BqshKsqHJb9Uc3tgC6ubDA0ALis/wupRg2wiotRP//7/CesBV
        xmn1Jf5syhq9mZQ1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=G47exBtKPU+yfFjJPgk5dM+ArvXS8
        AuS8jtMy5lW7d0=; b=P7UR9R3JNvkxvj7KubgB+usZxFzs9VXHYBs0Acf1UOzv4
        5bj81qPyYRDH2450Ek6UYVwcmoOaNI9T+IYO0cxwVVhASBA2DX1+CeLki23SZfCT
        vbaorpUIvJOPmHnNDgLORZFEDgOPUVXYdbjgzOLnqziQG7FKQoizjD9/+AueuTCd
        5LGFMDHIUle0LOiv9Inl49q/JR9fwI8gYVmyyvS+yZEp2SV+eozGJCm5YF2rsXYA
        U/ZNkWR7LDop+5zrs5UD5OLfOKkX6akwguxCUvLFLvqmHLzpHI+enzn7kxZV4y4t
        PRTRpKApX1hAMb+rtB6vOwenuGIo35oXLlfBbNBEg==
X-ME-Sender: <xms:VJ41YlLEeRZKPlFSuwsqQ8SosFQKU98CMW8jHzmhj6o5SR9eQF_DMg>
    <xme:VJ41YhJfyFdtrZhyNaYwn44ZyPKCw7tjkxyzmrCzVEykM80reEuDN1aivqw994Sm9
    NE74uKFrr2EDQfsIw>
X-ME-Received: <xmr:VJ41Ytv-sp2waBBUhf4J5Pk9-5yZSG8BkaPLkQFiUUDftHU1wrDa4O0MX5_9R7LlPMtDqt4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudefkecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertddtne
    cuhfhrohhmpefhvghrnhgrnhguohcutfgrmhhoshcuoehgrhgvvghnfhhoohesuhelvddr
    vghuqeenucggtffrrghtthgvrhhnpefgieefudehgeduheefveffhfffleeifeetfeefhe
    egieelkeeuhfeggeeutefhieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhprghs
    thgvsghinhdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehgrhgvvghnfhhoohesuhelvddrvghu
X-ME-Proxy: <xmx:VJ41Ymax9hZ5bP0NJCmLV5qOarDkKXHZbQF9NPR8n4Vr75xonVWP9g>
    <xmx:VJ41YsbwtqR0XJuIOpdbu7AYCTrD3K3NGqqxv14iS4QAuar-ETegUg>
    <xmx:VJ41YqAEpalNxxNubnjDD1jmGshEYezar2yHvcQLRJuwGt6wNDRImg>
    <xmx:VJ41YrxFQu30yc3uHm0lZyiN7gF9MjnBEtZclIBYFhw__ZBXDjIYNg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Mar 2022 05:11:46 -0400 (EDT)
From:   Fernando Ramos <greenfoo@u92.eu>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, davvid@gmail.com, sunshine@sunshineco.com,
        seth@eseth.com, levraiphilippeblain@gmail.com,
        rogi@skylittlesystem.org
Subject: [PATCH v5 0/3] vimdiff: new implementation with layout support
Date:   Sat, 19 Mar 2022 10:11:38 +0100
Message-Id: <20220319091141.4911-1-greenfoo@u92.eu>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone.

A few months ago I presented a patch series that reached v4, but then feedback
slowly died (see [5])

I'm re-posting a v5 (which is just a rebase of v4 on top of master) in case
there is still interest in considered this feature for inclusion.

As I said originally, I would completely understand if you decided not to merge
this work, as similar functionality can already be obtained by editing
".gitconfig" (this is all explained below).

Anyway... this is the text from the original RFC and subsequent revisions:

---

A few weeks ago I presented this RFC [1] where I introduced a new variant of the
vimdiff merge tool ("vimdiff4") that creates three tabs (instead of just one)
that look like this:

    ------------------------------------------
    | <TAB #1> |  TAB #2  |  TAB #3  |       |
    ------------------------------------------
    |             |           |              |
    |   LOCAL     |   BASE    |   REMOTE     |
    |             |           |              |   <---- Same information
    ------------------------------------------         presented by the
    |                                        |         "standard" vimdiff
    |                MERGED                  |         merge tool
    |                                        |
    ------------------------------------------
    
    ------------------------------------------
    |  TAB #1  | <TAB #2> |  TAB #3  |       |
    ------------------------------------------
    |                   |                    |
    |                   |                    |
    |                   |                    |
    |     BASE          |    LOCAL           |   <---- Only differences
    |                   |                    |         between BASE and
    |                   |                    |         LOCAL are shown
    |                   |                    |
    ------------------------------------------
    
    ------------------------------------------
    |  TAB #1  |  TAB #2  | <TAB #3> |       |
    ------------------------------------------
    |                   |                    |
    |                   |                    |
    |                   |                    |
    |     BASE          |    REMOTE          |   <---- Only differences
    |                   |                    |         between BASE and
    |                   |                    |         REMOTE are shown
    |                   |                    |
    ------------------------------------------


The motivation behind this was that, for non-trivial merges, the three way diff
presented in the first tab tends to be very confusing and in these cases
individual diffs between BASE and LOCAL and between BASE and REMOTE are very
useful.

I have been using a "custom" merge tool for months to achieve this same result
by adding these lines to my .gitconfig file:

  [mergetool "supermerge"]
        cmd = vim -f -d -c \"4wincmd w | wincmd J | tabnew | edit $LOCAL | vertical diffsplit $BASE | tabnew | edit $REMOTE | vertical diffsplit $BASE | 2tabprevious\" \"$LOCAL\" \"$BASE\" \"$REMOTE\" \"$MERGED\"
        trustExitCode = true

...and, because I found this "trick" very useful, I thought it would be a good
idea to add it as a git built-in merge tool (called "vimdiff4" because  1, 2 and
3 had already been taken) for everyone to use... and that's exactly what the RFC
I published did.

Now... as you can see in the RFC thread [1], David and Juno suggested that
maybe, instead of creating *yet another vimdiff variant*, we should take this
opportunity to:

  * Come up with a more general way of defining arbitrary vim layouts.
  
  * Re-implement "vimdiff1", "vimdiff2" and "vimdiff3" using this new mechanism
    (after all, the only difference among them is that they present different
    layouts to the user)

  * Add documentation to all of this.

And the result of that work is what I'm presenting today :)

Some things I would like to mention:

  1. There are three commits in this patch series:

     - The first one implements the logic to generate new arbitrary layouts and
       also re-defines "vimdiff1", "vimdiff2" and "vimdiff3" on top of it.

     - The second one adds documentation. It is probably a good idea to start
       reviewing this commit before the first one!

     - The last commit *is not meant to be merged now*. It removes "vimdiff1",
       "vimdiff2" and "vimdiff3", which is something that should only be done
       after one or two releases with a deprecation notice and only if everyone
       agrees to do so :)

  2. "mergetools/vimdiff" is now a ~800 lines bash script, but most of it is
     documentation (which is embedded in the tool itself for easier maintenance)
     and unit tests.
     I have only tested it with bash, but I've tried not to use any command not
     already being used somewhere else, so I expect it to work in the same
     places it was working before (however, let me know if there are some shell
     compatibility requirements and I'll try to check them).

  3. Regarding unit tests, "mergetool/vimdiff" contains instructions on how to
     run them (just call the script without arguments after making changes, to
     make sure you didn't break anything).
     Right now it prints "OK" on all test cases (obviously) [2]

  3. The "git {diff,merge}tool --tool-help" command now also prints the
     documentation for each tool (instead of just its name, as before).
     You can see an example of the output here ([3] and [4])

Finally, let me say that, while I like what this patch series achieves, I would
also *completely* understand if you decide not to merge it due to being a
complex solution to a simple problem that can be solved (as I had been doing up
until today) by just adding three line to one's .gitconfig.

  [mergetool "supermerge"]
        cmd = vim -f -d -c ...(custom complex sequence of vim commands)...
        trustExitCode = true

Let me know what you think.

Thanks.

References:

  [1] https://lore.kernel.org/git/20211019212020.25385-1-greenfoo@u92.eu/#r
  [2] https://pastebin.com/kuQ5pETG
  [3] https://pastebin.com/yvLWxeiM
  [4] https://pastebin.com/qNc7qymp
  [5] https://lore.kernel.org/git/YdSwXJzwuVM%2FMCAZ@zacax395.localdomain/


New in v2:

  * Remove deprecation of vimdiff{1,2,3} (they will remain for backwards
    compatibility, but built on top of the new generic layout mechanism)

  * Remove unnecessary "IFS="

  * Replace DEBUG --> GIT_MERGETOOL_VIMDIFF_DEBUG

  * Stop using "local" (turns out it was not necessary)

  * Stop using bash arrays (use arrays of variables instead)

  * Stop using bash substring expansion (use a new "substring" function
    instead).

  * Refactor some of the internal loops to make the code faster. This was needed
    because the two previous changes (specially the one where I stop using
    "substring expansion") slowed down the script to a point where I had to wait
    for a few *seconds* before the "layout" string was resolved (recursion +
    bash forks are a recipe for sluggishness). Fortunately we are back to the
    low hundreds of milliseconds range.

  * Change markers:
    - File to save: * --> @
    - New tab     : ; --> +
    - Vert split  : | --> ,
    - Horz split  : - --> /

  * Rewrite examples to use as few parenthesis as possible (typically zero)
    and better explain operators priority.

  * Other fixes to remove problems reported by "shellcheck --shell=sh" (which
    checks syntax agains the POSIX shell spec)

  * Rename "index_..." vars to make more obvious what they do.

  * Use "$" inside arithmetic expressions $((...))
    NOTE: "shellcheck" issues a warning stating that "$" is not needed inside
    arithmetic expressions.

  * Use "test -n" instead of "! test -z"

  * Use "=" instead of "==" in "test"

  * Use "= 0" instead of "-eq 0"

  * Do not use "eval" nor "--" when copying a file to MERGED

  * Do not use "-o" with grep

  * Use <<-\EOF instead of <<\ENDOFMESSAGE and remove extra indent in "here
    docs".

  * Also, let me put here some answers to questions made in the replies to
    version v1 of this patch set:

    > What do backticks do in here?
    >
    >     some_var=(
    >         `# Name`       "Rick Deckard"
    >         `# Age`        "Unknown"
    >         `# Occupation` "Blade runner"
    >     )

    The backticks execute the code inside, which is a comment (everything after
    a "#" is considered a comment by the shell), thus it does nothing.

    The `# ...` trick can be used to insert inline comments in bash. Another
    example:

        $ ls -l `# long format` -h `# human readable` *.txt

    In any case, as you can see in this new revision, because I'm no longer
    using bash arrays, this trick to comment each test case is not needed
    anymore.

    > Why is "eval" needed here:
    >
    >     eval "$merge_tool_path" \
    >              -f "$FINAL_CMD" "$LOCAL" "$BASE" "$REMOTE" "$MERGED"

    Variable "$FINAL_CMD" contains a string that looks like this:

        $ echo $FINAL_CMD
        -c "vim cmd 1 | vim cmd 2 | ..." -c "tabfirst"

    We need to call "vim" exactly like that, but if we do this...

         $ vim $FINAL_CMD

    ...then "vim" will be excev'ed with the following arguments:

        1. -c
        2. "vim
        3. cmd
        4. 1
        ...

    ...instead of the desired scenario:

       1. -c
       2. cmd 1 | cmd 2 | ...
       3. -c
       4. tabfirst

     Using "eval" fixes this. A shorter example shows how this works:

         $ A="1 \"2 3\""

         $ ls $A
         ls: cannot access '1': No such file or directory
         ls: cannot access '"2': No such file or directory
         ls: cannot access '3"': No such file or directory

         $ eval ls $A
         ls: cannot access '1': No such file or directory
         ls: cannot access '2 3': No such file or directory

  * Finally, I think I have addressed all comments to v1 *except for two
    things*:

        1. Moving the documentation to "Documentation/" instead of having it
           embedded inside the "mergetools/vimdiff" script.

        2. Move unit tests to the "test suit"

    For (1) I would like more details. Is the idea not to print any
    documentation when running "git mergetool --tool-help" and have all the
    details included in "git help mergetool" instead?
    Right now "git help mergetool" does not mention any tool specific details
    and, instead, redirects the user to "git mergetool --tool-help" (that's why
    I originally placed the new documentation there).
    In any case, all the doc has been placed on its own commit, so once we
    decide how to proceed its just a matter of reverting it.

    For (2) I still need to investigate how this is done and prepare a "v3" if
    needed :)


New in v3:

  * Rebase on top of latest master

  * Documentation moved to "Documentation/". Running "git mergetool
    --tool-help" now works like before (ie. it just lists all available merge
    tools) except that a one line reference to a "man" entry is also printed for
    those entries providing one (right now, only vimdiff):

        $ git mergetool --tool-help
        'git mergetool --tool=<tool>' may be set to one of the following:
                        araxis
                        meld
                        vimdiff
                                Run 'man git-mergetool--vimdiff' for details
                        vimdiff1
                                Run 'man git-mergetool--vimdiff' for details
                        ...

  * New test file "t/7609-mergetool--lib.sh" created. Right now it only
    contains one test which calls "mergetools/vimdiff" with a special
    environment set, causing layout unit tests to run.


New in v4:

  * Rebase on top of latest master

  * Stop using "$" inside arithmetic expressions.

  * Remove "!/bin/bash" from the top of the "vimdiff" script.

  * Update comment explaining how the "vimdiff" script can be run.

  * Fix spaces/tabs.

  * Change the way unit tests are run (now the script is directly sourced
    instead of calling bash)

  * Remove unnecessary "case/esac" structure.

  * Fix typo in documentation


New in v5:

  * Rebase on top of latest master


Fernando Ramos (3):
  vimdiff: new implementation with layout support
  vimdiff: add tool documentation
  vimdiff: integrate layout tests in the unit tests framework ('t'
    folder)

 Documentation/git-difftool--vimdiff.txt  |  40 ++
 Documentation/git-mergetool--vimdiff.txt | 195 ++++++++
 git-mergetool--lib.sh                    |  14 +
 mergetools/vimdiff                       | 560 +++++++++++++++++++++--
 t/t7609-mergetool--lib.sh                |  15 +
 5 files changed, 797 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/git-difftool--vimdiff.txt
 create mode 100644 Documentation/git-mergetool--vimdiff.txt
 create mode 100755 t/t7609-mergetool--lib.sh

-- 
2.35.1

