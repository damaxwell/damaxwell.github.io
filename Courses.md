---
layout: default
title: Courses
---
## Courses

{%for term in site.data.teaching %}
<div class="card">
<h3 style="margin-top: 10px">{{term.term}}</h3>
<ul style="margin-left: 0px; font-size: 1.1em;">
     {%for course in term.courses%}
       {%if course.url%}
<li> <a href="{{course.url}}">{{course.title}}</a></li>
       {%else%}
<li> <a href="{{course.external-url}}">{{course.title}}</a></li>
       {%endif%}
    {%endfor%}
</ul>
</div>
{% endfor %}