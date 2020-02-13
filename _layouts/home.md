---
layout: default
---

{% assign plang = page.lang | default: site.langs[0] | default: "en" %}
{% if site.pitch == null %}
  {% assign div_class = "home" %}
{% else %}
  {% assign div_class = "home pitch" %}
{% endif %}

<div class="about-col-wrapper">
  <div class="about-col about-col-1">

    {% if site.github_username %}
    <img class="user-picture" src="https://github.com/{{ site.github_username }}.png" alt="{{ site.author }}">
    {% endif %}

    <ul class="contact-list">
      {% if site.email %}
      <li>
        {% include _icons/email.html username=site.email %}
      </li>
      {% endif %}

      {% if site.curriculum.url %}
      <li>
        {% include _icons/file.html curriculum=site.curriculum %}
      </li>
      {% endif %}
    </ul>

    <ul class="contact-list">
      {% if site.author_website %}
      <li>
        {% include _icons/website.html url=site.author_website %}
      </li>
      {% endif %}
    </ul>

    {% include contactlist.html %}

  </div>
  <article class="about-col about-col-2" itemscope itemtype="http://schema.org/BlogPosting">

    <h1>{{ page.title }}</h1>

    <div class="post-content" itemprop="articleBody">
      {{ content }}
    </div>

  </article>
</div>


<div class="{{ div_class }}">
  <h3>Latest posts:</h3>

  {% include post-ul.html limit=true %}


  {% assign nb_posts = site.posts | size %}

  {% if nb_posts > site.nb_posts_page %}
  <div class="archive">
    {{ site.data.academic_i18n.all_posts[plang][0] }}
    <a href="{% include _i18n/link.html path="archive" %}">{{ site.data.academic_i18n.all_posts[plang][1] }}</a>.</div>
  {% endif %}

</div>