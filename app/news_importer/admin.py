from django.contrib import admin

from .models import *


class FeedAdmin(admin.ModelAdmin):
    list_display = (
        'rss_url',
        'enabled',
    )
    list_filter = (
        'enabled',
    )


class ArticleAdmin(admin.ModelAdmin):
    list_display = (
        'source',
        'title',
        'added_at',
    )
    list_filter = (
        'added_at',
    )


admin.site.register(Feed, FeedAdmin)
admin.site.register(Article, ArticleAdmin)
