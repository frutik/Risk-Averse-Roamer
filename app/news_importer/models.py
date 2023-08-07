from django.db import models


class Feed(models.Model):
    rss_url = models.CharField(
        max_length=355,
        unique=True
    )
    enabled = models.BooleanField(
        default=True
    )


class Article(models.Model):
    source = models.ForeignKey(
        Feed,
        related_name="articles",
        on_delete=models.CASCADE
    )
    title = models.CharField(
        max_length=355,
        unique=True
    )
    txt = models.TextField(
    )
    added_at = models.DateTimeField(
        auto_now_add=True
    )
