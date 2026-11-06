"""A pytest plugin that moves the LearningResource id sequence to 998 before the bad-data test.

On a long xdist worker the sequence gets there by itself: Postgres sequences are not rolled back
between tests.
"""

import pytest


@pytest.fixture(autouse=True)
def _learning_resource_ids_at_998(request):
    if request.node.name != "test_learning_path_items_endpoint_create_item_bad_data":
        return
    request.getfixturevalue("db")
    from django.db import connection

    with connection.cursor() as cursor:
        cursor.execute(
            "SELECT setval(pg_get_serial_sequence('learning_resources_learningresource', 'id'), 998)"
        )
