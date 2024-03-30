String baseUrl = "https://jsonplaceholder.typicode.com/",
    postUrl = "${baseUrl}posts";

String postDetailUrl(int postId) => "${baseUrl}posts/$postId";

String postCommentsUrl(int postId) => "${baseUrl}posts/$postId/comments";
