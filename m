Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C427BC433F5
	for <git@archiver.kernel.org>; Fri, 27 May 2022 15:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353597AbiE0POJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 11:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbiE0POH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 11:14:07 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5ED3914B
        for <git@vger.kernel.org>; Fri, 27 May 2022 08:14:05 -0700 (PDT)
Received: from [90.198.244.89] (helo=[192.168.0.6])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nubf9-0003Ti-Dg;
        Fri, 27 May 2022 16:14:04 +0100
Message-ID: <b269bafc-0a9e-e676-6fb7-10c39212985b@iee.email>
Date:   Fri, 27 May 2022 16:14:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: About GIT Internals
Content-Language: en-US
To:     Aman <amanmatreja@gmail.com>
References: <CACMKQb0Mz4zBoSX2CdXkeF51z_mh3had7359J=LmXGzJM1WYLg@mail.gmail.com>
 <Yo68+kjAeP6tnduW@invalid> <8adba93c-7671-30d8-5a4c-4ad6e1084a22@iee.email>
 <CACMKQb3exv13sYN5uEP_AG-JYu1rmVj4HDxjdw8_Y-+maJPwGg@mail.gmail.com>
 <0201db28-d788-4458-e31d-c6cdedf5c9cf@iee.email>
 <C4B1A93D-800F-4C49-93D5-86FE58B1DDCA@hxcore.ol>
From:   Philip Oakley <philipoakley@iee.email>
Cc:     Git List <git@vger.kernel.org>
In-Reply-To: <C4B1A93D-800F-4C49-93D5-86FE58B1DDCA@hxcore.ol>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/05/2022 16:01, Aman wrote:
>
> Hey, thank you again.
>
> I am finding this mailing list format of talking a bit confusing, sorry.
>
No problem, blame Microsoft for following the business ($$$) way of 
doing stuff.

The 'plain text, in-line replies, with trimming of unrelated items' 
style helps the lurkers, and folks who come to the discussion later.

Main point is that we convert each point of interest into its own 
discussion, rather than it being a big challenge-response style between 
legal negotiators - it's not a win/lose discussion ;-)


> Would there be any way address everyone on the mailing list – like in 
> the future – to continue this conversation about git internals?
>
Key method is to locate the "reply All" option in your mail app. That 
makes sure every one in the discussion is copied, and the mailing lists 
as well for all the 'lurkers';-)

The mailing list archive uses both the message titles and any 
in-reply-to hidden headers (see if your mailer has a 'show source' 
option to see those interesting bits) to organise the list archive.
>
> I found out the mailing list archive (so confusing)– and saw these 
> personal replies don’t get added in the thread. I would appreciate if 
> you give some advice, thank you
>
> Sent from Mail <https://go.microsoft.com/fwlink/?LinkId=550986> for 
> Windows
>
> From: Philip Oakley <mailto:philipoakley@iee.email>
> Sent: 27 May 2022 08:10 PM
> To: Aman <mailto:amanmatreja@gmail.com>
> Cc: Git List <mailto:git@vger.kernel.org>; git-vger@eldondev.com
> Subject: Re: About GIT Internals
>
> Hi Aman,
>
> We try to keep all the cc's so every one can gain from the learning!
>
> comments in-line.
>
> On 26/05/2022 15:17, Aman wrote:
>
> > Hey Phillip.
>
> >
>
> > Thanks a lot for your email, and for sharing the book! This is great.
>
> That was Eldon, thank you..
>
> (https://lore.kernel.org/git/Yo68+kjAeP6tnduW@invalid/)
>
> There is also the Git Magic 'book' from Stanford, with Ch8 covering the
>
> internals http://www-cs-students.stanford.edu/~blynn/gitmagic/ch08.html
>
> >
>
> > Just a  follow up questions- if you don't mind:
>
> >
>
> > 1. I haven't had the experience of working with other (perhaps even
>
> > older) version control systems, like subversion. So when refering to
>
> > the "control" aspect,
>
> The "control" aspect was from whoever was the 'manager' that limited
>
> access to the version system (i.e. acting like a museum curator), and
>
> deciding if your masterpiece was worthy of inclusion as a significant
>
> example of your craft, whether that was an engineering drawing or some
>
> software code.
>
> >   you mean because with hashes we can verify
>
> If you have a look at
>
> https://www.makeuk.org/insights/blogs/how-to-read-engineering-drawings-a-simple-guide 
>
>
> and the part about the Title Block has a drawing (DWG) number
>
> (EEF-001-AM) that is used to reference it and, while it feels nice, the
>
> reference is rather arbitrary, (could someone else use that number?
>
> what's the next in the sequence? what happens when we reach EEF-999-AM?
>
> etc.).
>
> So the computer hash (40 digits of 0-9a-f !) solves all those problems,
>
> it is unique (>40 card shuffle level), depends only on the content,
>
> computers like it. Yay.
>
> (Computers are great at perfect replication, so cost of manufacture
>
> tends to zero! Cost of design wanders in the other direction;-)
>
> > the
>
> > integrity of the files (like code) in git - there is no need for
>
> > having a central authority to guarantee that's it's the right content
>
> > files (which is great)?
>
> And it means managers no longer worry about _your_ working copy -
>
> computers have digital storage space to spare. That wasn't the case when
>
> it was on paper, and we didn't have photocopies - have a look at 'blue
>
> prints' https://en.wikipedia.org/wiki/Blueprint (see the invention
>
> date!, I still remember the smell from the late 1970s)
>
> >
>
> > On Thu, May 26, 2022 at 2:17 PM Philip Oakley 
> <philipoakley@iee.email> wrote:
>
> >> On 26/05/2022 00:34, git-vger@eldondev.com wrote:
>
> >>> Hi Aman, responses inline below.
>
> >>>
>
> >>> On Wed, May 25, 2022 at 09:40:42PM +0530, Aman wrote:
>
> >>>> Could someone please assist - in sharing some resources - which I
>
> >>>> could go through, to better understand GIT software internals.
>
> >>> There is an excellent free book at https://git-scm.com/book/en/v2 .
>
> >>>
>
> >>> Chapter 10 is about git internals. It is important to realize that,
>
> >>> unlike many other version control systems, git works effectively on
>
> >>> files locally on your computer, without any server or other shared
>
> >>> resources to manage. Also, one good way to learn may be to form a
>
> >>> question that you want to answer first. "How do I ...." or "what 
> happens
>
> >>> when I ...". Since git works locally, it is possible to create a git
>
> >>> repo, look at the files contained in the .git directory, take action
>
> >>> with git, and then look at the files again.
>
> >>>
>
> >>>
>
> >> Another Git feature, compared to older version control systems, is that
>
> >> it flips the 'control' aspect on its head. (who controls what you can
>
> >> store?)
>
> >>
>
> >> It does this by using the hash (sha1, or sha256) values as a way of
>
> >> users _checking_ that they have the right copy of a file or commit,
>
> >> rather than needing special permissions to access (write/read) some
>
> >> alleged 'master' copy (in the sense of a unique artefact) of the
>
> >> particular version. Maintainers now check and authorise particular
>
> >> versions much more easily.
>
> >>
>
> >> Hence Git _Distributes Control_ - you no longer need permission to keep
>
> >> versioned copies of your work. This was, in my mind, a core element of
>
> >> its success.
>
> >>
>
> >> There is other stuff about how Git splits the (file) content from it's
>
> >> meta-data, so if say 10 files contain the same licence text, then it
>
> >> only hold one copy of that text, with its own unique hash. Then has a
>
> >> hierarchy (pyramid) of hashes of the meta-data to build up a whole
>
> >> project's hash (the top level 'tree'), and the same hierarchy technique
>
> >> is repeated for the project's history of commits.
>
> >>
>
> >> If you have a copy of the repository with the latest (same) hash then
>
> >> you have a perfect copy, indistinguishable to the 'original'! Older
>
> >> versioning systems did not have those guarantees, many were derived 
> from
>
> >> systems for versioning engineering and architectural drawings such as
>
> >> those that were used for the RMS Titanic or Empire State Building.
>
> >>
>
> >> Philip
>
> >>
>
> >> PS it's worth checking out the distinction between having hash (a magic
>
> >> id) of some text, and encrypting (a magic translation of) some text.
>
> >>
>
> >>
>

