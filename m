Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB90C433FE
	for <git@archiver.kernel.org>; Mon,  3 Oct 2022 17:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiJCR1C (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Oct 2022 13:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiJCR0s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2022 13:26:48 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C6517AB6
        for <git@vger.kernel.org>; Mon,  3 Oct 2022 10:26:47 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id gf8so7913788pjb.5
        for <git@vger.kernel.org>; Mon, 03 Oct 2022 10:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:subject:to:from:sender:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FqpvZdYKv7W3ydt3L1QDRoF4J7RNC6ck++JrVoiFyrk=;
        b=Q395cmWVrj35xMhSJGo8fx5MF/prDMIcoo7O7p7yW9dXTe16q28jXmWgH6TxAdwIXt
         tzXh0YhJkkRANwp2K5QpeZUxUIB//1vDv63fYrJ/iIuhGLmHv8MOP9Z7Ehwn5LilFhuP
         naBX1xw8tC3T7HefwzPoumT57TkBoC3aeo9++MSGlNmCuZnbBjBbHD/zRl5DbaD+MLbp
         i//MYISYSoxZKizK9KOTzz++UyGx2bXZb9Gpw9uT3HzSCcYFKVasn4CzGFbdd7cMnfSX
         Pn7NXaI9qlUDrHdfazcKHWJGByjQOXwzhe9uCJ/tZE5k+ARKNf+FMRsizMk8Sk7g8mEf
         EERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:subject:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FqpvZdYKv7W3ydt3L1QDRoF4J7RNC6ck++JrVoiFyrk=;
        b=z62SMHk/AcVFM/fFkfwx6lFHigR6IcjZ48I3K2qsfE5JXKCJQFBYjbkDfXVnBALhVQ
         ayLRBVMGvBA8wUuZrL9h03leYGKMlJ7CNrABciwsFqyvQ9yeElidzdUhOnlAaZ0IIq85
         nV0L31tO4QVoLE6VEQc7VSi6arXu6u1wtFDH0TFbH/eSGkr/oXOpNJX6g2FLH3kaQuzd
         DkoekCk8O99b12ddQa8Aag4sK1n753/KD/NpeIXPrQQCSEMrWVNPG0rIJoVQ9uMaw5l1
         1SZ2lMskdNHvN2jfQt8Bll+ngzafXlOkyc4T2z+ht+eWeI+YDE9l8w51ecIsATaJVDXl
         y2Pw==
X-Gm-Message-State: ACrzQf0XHlAoeSsNDFu5P7zUyGUipANyGHXNyCSYAJy7Umtuh9/O+/uN
        DmhcA2LZRZjg9ChGKqhcRiVnz1xBSzA=
X-Google-Smtp-Source: AMsMyM68ce3MRh1a6wKV9l+kXchtNc6bavvCmlJ9xcCSN2a/DB2pQS9+noOg2wpz44D0bRiuLnYw3g==
X-Received: by 2002:a17:902:bb96:b0:17d:9ed7:e9af with SMTP id m22-20020a170902bb9600b0017d9ed7e9afmr12044290pls.15.1664818006099;
        Mon, 03 Oct 2022 10:26:46 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id q12-20020a65624c000000b0043a1c0a0ab1sm6864277pgv.83.2022.10.03.10.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 10:26:45 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: A note from the maintainer
Date:   Mon, 03 Oct 2022 10:26:45 -0700
Message-ID: <xmqqbkqsu8bu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Welcome to the Git development community.

This message is written by the maintainer and talks about how Git
project is managed, and how you can work with it.

The current maintainer is Junio C Hamano <gitster@pobox.com>; please
do not send any message to this address unless it also goes to the
mailing list, because it is likely that such a message will not be
seen by any human being.  Spam filters learned that legitimate
messages to the address come only from a very few sender addresses
that are known to be good, and messages from all others are likely to
be spam unless they are also sent to the mailing list at the same time
(i.e. "Reply-all" to the list message would reach the mailbox, but
"Reply" will likely be thrown into the spam folder).


* Mailing list and the community

The development is primarily done on the Git mailing list. Help
requests, feature proposals, bug reports and patches should be sent to
the list address <git@vger.kernel.org>.  You don't have to be
subscribed to send messages.  The convention on the list is to keep
everybody involved on Cc:, so it is unnecessary to say "Please Cc: me,
I am not subscribed".

As an anti-spam measure, the mailing list software rejects messages
that are not text/plain and drops them on the floor.  If you are a
GMail user, you'd want to make sure "Plain text mode" is checked.

Before sending patches, please read Documentation/SubmittingPatches
and Documentation/CodingGuidelines to familiarize yourself with the
project convention.

If you sent a patch and you did not hear any response from anybody for
several days, it could be that your patch was totally uninteresting,
but it also is possible that it was simply lost in the noise.  Please
do not hesitate to send a reminder message in such a case.  Messages
getting lost in the noise may be a sign that those who can evaluate
your patch don't have enough mental/time bandwidth to process them
right at the moment, and it often helps to wait until the list traffic
becomes calmer before sending such a reminder.

The list archive is available at a few public sites:

        http://lore.kernel.org/git/
        http://marc.info/?l=git
        http://www.spinics.net/lists/git/

For those who prefer to read it over NNTP:

	nntp://nntp.lore.kernel.org/org.kernel.vger.git
        nntp://news.public-inbox.org/inbox.comp.version-control.git

are available.

When you point at a message in a mailing list archive, using its
message ID is often the most robust (if not very friendly) way to do
so, like this:

	http://lore.kernel.org/git/Pine.LNX.4.58.0504150753440.7211@ppc970.osdl.org

Often these web interfaces accept the message ID with enclosing <>
stripped (like the above example to point at one of the most important
message in the Git list).

Some members of the development community can sometimes be found on
the #git and #git-devel IRC channels on Libera Chat.  Their logs are
available at:

        http://colabti.org/irclogger/irclogger_log/git
        http://colabti.org/irclogger/irclogger_log/git-devel

There is a volunteer-run newsletter to serve our community ("Git Rev
News" http://git.github.io/rev_news/).

Git is a member project of software freedom conservancy, a non-profit
organization (https://sfconservancy.org/).  To reach a committee of
liaisons to the conservancy, contact them at <git@sfconservancy.org>.

For our expectations on the behaviour of the community participants
towards each other, see CODE_OF_CONDUCT.md at the top level of the source
tree, or:

    https://github.com/git/git/blob/master/CODE_OF_CONDUCT.md


* Reporting bugs

When you think git does not behave as you expect, please do not stop
your bug report with just "git does not work".  "I used git in this
way, but it did not work" is not much better, neither is "I used git
in this way, and X happend, which is broken".  It often is that git is
correct to cause X happen in such a case, and it is your expectation
that is broken. People would not know what other result Y you expected
to see instead of X, if you left it unsaid.

Please remember to always state

 - what you wanted to achieve;

 - what you did (the version of git and the command sequence to reproduce
   the behavior);

 - what you saw happen (X above);

 - what you expected to see (Y above); and

 - how the last two are different.

See http://www.chiark.greenend.org.uk/~sgtatham/bugs.html for further
hints.  Our `git bugreport` tool gives you a handy way you can use to
make sure you do not forget these points when filing a bug report.

If you think you found a security-sensitive issue and want to disclose
it to us without announcing it to wider public, please contact us at
our security mailing list <git-security@googlegroups.com>.  This is
a closed list that is limited to people who need to know early about
vulnerabilities, including:

  - people triaging and fixing reported vulnerabilities
  - people operating major git hosting sites with many users
  - people packaging and distributing git to large numbers of people

where these issues are discussed without risk of the information
leaking out before we're ready to make public announcements.


* Repositories and documentation.

My public git.git repositories are (mirrored) at:

  https://git.kernel.org/pub/scm/git/git.git/
  https://kernel.googlesource.com/pub/scm/git/git
  https://repo.or.cz/alt-git.git/
  https://github.com/git/git/
  https://gitlab.com/git-vcs/git/

This one shows not just the main integration branches, but also
individual topics broken out:

  https://github.com/gitster/git/

A few web interfaces are found at:

  http://git.kernel.org/pub/scm/git/git.git
  https://kernel.googlesource.com/pub/scm/git/git
  http://repo.or.cz/w/alt-git.git

Preformatted documentation from the tip of the "master" branch can be
found in:

  https://git.kernel.org/pub/scm/git/git-{htmldocs,manpages}.git/
  https://repo.or.cz/git-{htmldocs,manpages}.git/
  https://github.com/gitster/git-{htmldocs,manpages}.git/

The manual pages formatted in HTML for the tip of 'master' can be
viewed online at:

  https://git.github.io/htmldocs/git.html


* How various branches are used.

There are four "integration" branches in git.git repository that track
the source tree of git: "master", "maint", "next", and "seen".  They
however almost never get new commits made directly on them.  Instead,
a branch is forked from either "master" or "maint" for each "topic",
whether it is a new feature or fix for a bug, and holds a set of
commits that belong to the same theme, and then such a "topic branch"
is merged to these integration branches.

The "master" branch is meant to contain what are very well tested and
ready to be used in a production setting.  Every now and then, a
"feature release" is cut from the tip of this branch.  They used to be
named with three dotted decimal digits (e.g. "1.8.5"), but we have
switched the versioning scheme and "feature releases" are named with
three-dotted decimal digits that ends with ".0" (e.g. "1.9.0").

The last such release was 2.38 done on Oct 3rd, 2022.  You can expect
that the tip of the "master" branch is always more stable than any of
the released versions.

Whenever a feature release is made, "maint" branch is forked off from
"master" at that point.  Obvious and safe fixes after a feature
release are merged to this branch and maintenance releases are cut
from it.  Usually these fixes are merged to the "master" branch first,
several days before merged to the "maint" branch, to reduce the chance
of last-minute issues, but things like embargoed security fixes may
first appear in the maintenance tracks and merged up to "master" at
the same time.  The maintenance releases used to be named with
four dotted decimal, named after the feature release they are updates
to (e.g. "1.8.5.1" was the first maintenance release for "1.8.5"
feature release).  These days, maintenance releases are named by
incrementing the last digit of three-dotted decimal name (e.g.
"2.29.2" was the second maintenance release for the "2.29" series).

New features never go to the "maint" branch.  It is merged into
"master" primarily to propagate the description in the release notes
forward.

A new development does not usually happen on "master". When you send a
series of patches, after review on the mailing list, a separate topic
branch is forked from the tip of "master" (or somewhere older, especially
when the topic is about fixing an earlier bug) and your patches are queued
there, and kept out of "master" while people test it out. The quality of
topic branches are judged primarily by the mailing list discussions.

Topic branches that are in good shape are merged to the "next" branch. In
general, the "next" branch always contains the tip of "master".  It might
not be quite rock-solid, but is expected to work more or less without major
breakage. The "next" branch is where new and exciting things take place. A
topic that is in "next" is expected to be polished to perfection before it
is merged to "master".  Please help this process by building & using the
"next" branch for your daily work, and reporting any new bugs you find to
the mailing list, before the breakage is merged down to the "master".

The "seen" (formerly "pu", proposed updates) branch bundles all the
remaining topic branches the maintainer happens to have seen.  There
is no guarantee that the maintainer has enough bandwidth to pick up any
and all topics that are remotely promising from the list traffic, so
please do not read too much into a topic being on (or not on) the "seen"
branch.  This branch is mainly to remind the maintainer that the topics
in them may turn out to be interesting when they are polished, nothing
more.  The topics on this branch aren't usually complete, well tested,
or well documented and they often need further work.  When a topic that
was in "seen" proves to be in a testable shape, it is merged to "next".

You can run "git log --first-parent master..seen" to see what topics are
currently in flight.  Sometimes, an idea that looked promising turns out
to be not so good and the topic can be dropped from "seen" in such a case.
The output of the above "git log" talks about a "jch" branch, which is an
early part of the "seen" branch; that branch contains all topics that
are in "next" and a bit more (but not all of "seen") and is used by the
maintainer for his daily work.

The two branches "master" and "maint" are never rewound, and "next"
usually will not be either.  After a feature release is made from
"master", however, "next" will be rebuilt from the tip of "master"
using the topics that didn't make the cut in the feature release.
Some topics that used to be in "next" during the previous cycle may
get ejected from "next" when this happens.

A natural consequence of how "next" and "seen" bundles topics together
is that until a topic is merged to "next", updates to it is expected
by replacing the patch(es) in the topic with an improved version,
and once a topic is merged to "next", updates to it needs to come as
incremental patches, pointing out what was wrong in the previous
patches and how the problem was corrected.

Note that being in "next" is not a guarantee to appear in the next
release, nor even in any future release.  There were cases that topics
needed reverting a few commits in them before graduating to "master",
or a topic that already was in "next" was reverted from "next" because
fatal flaws were found in it after it was merged to "next".


* Other people's trees.

Documentation/SubmittingPatches outlines to whom your proposed changes
should be sent.  As described in contrib/README, I would delegate fixes
and enhancements in contrib/ area to the primary contributors of them.

Although the following are included in git.git repository, they have their
own authoritative repository and maintainers:

 - git-gui/ comes from git-gui project, maintained by Pratyush Yadav:

        https://github.com/prati0100/git-gui.git

 - gitk-git/ comes from Paul Mackerras's gitk project:

        git://ozlabs.org/~paulus/gitk

 - po/ comes from the localization coordinator, Jiang Xin:

	https://github.com/git-l10n/git-po/

When sending proposed updates and fixes to these parts of the system,
please base your patches on these trees, not git.git (the former two
even have different directory structures).
