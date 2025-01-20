---
layout: default
title: David Maxwell
is_root: true
---
<!-- <div style="display: flex; align-items: flex-start; gap: 30px; margin-top: 30px;">
    <div style="flex-shrink: 1;">
        <img src="maxwell.jpg" style="height: 150px; width: auto; max-height: 150px; max-width: min(150px, 30vw); border-radius: 10px; object-fit: cover;">
    </div>
    <div style="flex: 1; min-width: 0;">
        <p style="margin-top: 0px">
        <b>Professor of Mathematics</b><br>
        <b>University of Alaska Fairbanks</b>
        </p>
        <p>
        <b>Office:</b> Chapman 308C<br>
        <b>E-mail:</b> <a href="mailto:damaxwell@alaska.edu">damaxwell@alaska.edu</a><br>
        </p>
    </div>
</div> -->

<div class="profile-container">
    <div class="title-section mobile-only">
        <p class="title-text">
            <b>Professor of Mathematics</b><br>
            <b>University of Alaska Fairbanks</b>
        </p>
    </div>
    
    <div class="layout-container">
        <div class="image-container">
            <img src="maxwell.jpg" alt="Profile photo">
        </div>
        <div class="text-content">
            <div class="title-section desktop">
                <p class="title-text">
                    <b>Professor of Mathematics</b><br>
                    <b>University of Alaska Fairbanks</b>
                </p>
            </div>
            <div class="contact-info">
                <p> <span style="margin-right: 0.2em"><b>Office:</b></span><span class="tiny-break"><br></span> Chapman 308C</p>
                <p> <span style="margin-right: 0.2em"><b>E-mail:</b></span><span class="tiny-break"><br></span> <a href="mailto:damaxwell@alaska.edu">damaxwell@alaska.edu</a></p>
            </div>
        </div>
    </div>
</div>


## Current Courses
<!-- <div class="card"> -->
{%for term in site.data.teaching %}
  {%if term.term == site.active_term%}
<ul style="margin-left: 0px; font-size: 1.1em;">
     {%for course in term.courses%}
       {%if course.url%}
<li> <a href="{{course.url}}">{{course.title}}</a></li>
       {%else%}
<li> <a href="{{course.external-url}}">{{course.title}}</a></li>
       {%endif%}
    {%endfor%}
</ul>
  {%endif%}
{%endfor%}
<!-- </div> -->

## Presentations

<div class="card">
<h3>How Large Language Models Operate</h3>

<b>UAF Math Colloquium</b><br />
<b>Time:</b> 1pm-2pm<br />
<b>Dates:</b> November 7 and 26, 2024<br />

<p />
	<table class="asst-table">
		<tr><td>Lecture I</td><td><a href="llm/UAF-LLM-2024.pdf">Slides</a></td><td><a href="https://media.uaf.edu/media/t/1_nsfqik10">Video</a></td>
		</tr>
		<tr><td>Lecture II</td><td><a href="llm/UAF-LLM-2024.pdf">Slides</a></td><td><a href="https://media.uaf.edu/media/t/1_nsfqik10">Video</a></td>
		</tr>
	</table>

	<p>
	In the last couple of years generative AI, and Large Language Models (LLMs) especially, have captured the public's attention. We've all used ChatGPT and friends by now. But how do they operate? </p>

	<p>
	In this talk I aim to provide a good mental model of what is happening in the background when interacting with an LLM. I'll give an overview of how LLMs work broadly, and then dive a bit into the details of GPT-2.0, the precursor to the GPT models we use today. In particular, I'll discuss the transformer architecture, which is the foundation technology driving the current generative AI revolution.</p>
	
	<p>
	This will be a broadly accessible talk, aimed at a general STEM audience.	</p>
</div>

<div class="card">
<h3>An Unhelpful Introduction to Electricity and Magnetism</h3>

<b>Fall 2020 Short Lecture Series</b><br />
<b>Time:</b> 1pm-2pm<br />
<b>Dates:</b> Tuesday, November 10, 17 and 24 2020<br />
<b>Talk Link:</b> <a href="https://alaska.zoom.us/j/86362808870?pwd=SGlzbVBaQWg0RWV0YzJhTk05dnk0UT09">Zoom</a>
<p />

<table class="asst-table">
	<tr><td>Lecture I</td><td><a href="unhelpful-e-and-m/unhelpful-e-and-m-part-1.pdf">Slides</a></td><td><a href="https://media.uaf.edu/media/t/1_ijmgmx0p">Video</a></td>
	</tr>
	<tr><td> Lecture II</td><td><a href="unhelpful-e-and-m/unhelpful-e-and-m-part-2.pdf">Slides</a></td><td><a href="https://media.uaf.edu/media/t/1_4a73d54g?st=629&ed=4074">Video</a></td>
	</tr>
	<tr><td> Lecture IIIa</td><td><a href="unhelpful-e-and-m/unhelpful-e-and-m-part-3a.pdf">Slides</a></td><td><a href="https://media.uaf.edu/media/t/1_pw2wgvuk?st=382&ed=4088">Video</a></td>
	</tr>
	<tr><td> Lecture IIIb</td><td><a href="unhelpful-e-and-m/unhelpful-e-and-m-part-3b.pdf">Slides</a></td><td><a href="https://media.uaf.edu/media/t/1_2ha3ygy9?st=360&ed=5069">Video</a></td>
	</tr>
</table>


<p>
Electromagnetism is a deeply geometric physical phenomenon, an aspect that is hidden in its standard presentation.
The standard presentation is efficient and effective if you want to teach people how to build radios and motors. But it turns out be be essential to understand the underlying geometry of electromagnetism when studying its relationship with general relativity, a manifestly geometric theory.</p>

<p>In this three-part sequence of lectures we present an unhelpful introduction to electromagnetism in the sense that it is useless for building the intuition needed to construct motors and radios and solar panels, but highlights the very simple geometric ideas and principles that give rise to electromagentism.  The talks will be accessible to people with a modest mathematics background (calculus III) who have a passing interest in physics, as well as people who know far more physics than I do who would like to see a mathematician grapple with gauge theory.</p>

<p>The lectures:
<ul>
<li>Part I: Really unhelpful.  No physics even.</li>
<li>Part II: A little physics: the emergence of E and B from geometry and symmetry.</li>
<li>Part III: (That other) Maxwell's equations.</li>
</ul>
</p>

</div>


