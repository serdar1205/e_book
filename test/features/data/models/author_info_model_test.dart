import 'dart:convert';
import 'package:e_book/features/data/model/author_info_model.dart';
import 'package:e_book/features/domain/entity/author_info_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  const tAuthorInfoModel = AuthorInfoModel(
      authorId: 3389,
      name: 'Stephen King',
      image: 'https://images.gr-assets.com/authors/1362814142p5/3389.jpg',
      info:
          'Stephen Edwin King was born the second son of Donald and Nellie Ruth Pillsbury King. After his father left them when Stephen was two, he and his older brother, David, were raised by his mother. Parts of his childhood were spent in Fort Wayne, Indiana, where his father\'s family was at the time, and in Stratford, Connecticut. When Stephen was eleven, his mother brought her children back to Durham, Maine, for good. Her parents, Guy and Nellie Pillsbury, had become incapacitated with old age, and Ruth King was persuaded by her sisters to take over the physical care of them. Other family members provided a small house in Durham and financial support. After Stephen\'s grandparents passed away, Mrs. King found work in the kitchens of Pineland, a nearby residential facility for the mentally challenged.Stephen attended the grammar school in Durham and Lisbon Falls High School, graduating in 1966. From his sophomore year at the University of Maine at Orono, he wrote a weekly column for the school newspaper, THE MAINE CAMPUS. He was also active in student politics, serving as a member of the Student Senate. He came to support the anti-war movement on the Orono campus, arriving at his stance from a conservative view that the war in Vietnam was unconstitutional. He graduated in 1970, with a B.A. in English and qualified to teach on the high school level. A draft board examination immediately post-graduation found him 4-F on grounds of high blood pressure, limited vision, flat feet, and punctured eardrums.He met Tabitha Spruce in the stacks of the Fogler Library at the University, where they both worked as students; they married in January of 1971. As Stephen was unable to find placement as a teacher immediately, the Kings lived on his earnings as a laborer at an industrial laundry, and her student loan and savings, with an occasional boost from a short story sale to men\'s magazines.Stephen made his first professional short story sale ("The Glass Floor") to Startling Mystery Stories in 1967. Throughout the early years of his marriage, he continued to sell stories to men\'s magazines. Many were gathered into the Night Shift collection or appeared in other anthologies.In the fall of 1971, Stephen began teaching English at Hampden Academy, the public high school in Hampden, Maine. Writing in the evenings and on the weekends, he continued to produce short stories and to work on novels.',
      rating: 4.06,
      genres: [
        "Horror",
        "Mystery",
        "Literature & Fiction"
      ],
      authorBooks: [
        AuthorBooks(
            url: 'https://www.goodreads.com/book/show/11588.The_Shining',
            name: 'The Shining (The Shining, #1)',
            rating: 4.26,
            date: 1977,
            bookId: '11588'),
        AuthorBooks(
            url: 'https://www.goodreads.com/book/show/830502.It',
            name: 'It',
            rating: 4.25,
            date: 1986,
            bookId: '830502'),
      ]);

  test('should be a subclass of AuthorInfoEntity', () async {
    expect(tAuthorInfoModel, isA<AuthorInfoEntity>());
  });

  test('fromMap', () async {
    //arrange
    final Map<String, dynamic> jsonMap =
        json.decode(fixtureReader('author_info.json'));
    //act
    final result = AuthorInfoModel.fromMap(jsonMap);
    //assert
    expect(result, tAuthorInfoModel);
  });

  test('toMap', () async {
    final result = tAuthorInfoModel.toMap();
    final expectedtAuthorInfoMap = {
      "author_id": 3389,
      "name": "Stephen King",
      "image": "https://images.gr-assets.com/authors/1362814142p5/3389.jpg",
      "rating": 4.06,
      "info":
          "Stephen Edwin King was born the second son of Donald and Nellie Ruth Pillsbury King. After his father left them when Stephen was two, he and his older brother, David, were raised by his mother. Parts of his childhood were spent in Fort Wayne, Indiana, where his father's family was at the time, and in Stratford, Connecticut. When Stephen was eleven, his mother brought her children back to Durham, Maine, for good. Her parents, Guy and Nellie Pillsbury, had become incapacitated with old age, and Ruth King was persuaded by her sisters to take over the physical care of them. Other family members provided a small house in Durham and financial support. After Stephen's grandparents passed away, Mrs. King found work in the kitchens of Pineland, a nearby residential facility for the mentally challenged.Stephen attended the grammar school in Durham and Lisbon Falls High School, graduating in 1966. From his sophomore year at the University of Maine at Orono, he wrote a weekly column for the school newspaper, THE MAINE CAMPUS. He was also active in student politics, serving as a member of the Student Senate. He came to support the anti-war movement on the Orono campus, arriving at his stance from a conservative view that the war in Vietnam was unconstitutional. He graduated in 1970, with a B.A. in English and qualified to teach on the high school level. A draft board examination immediately post-graduation found him 4-F on grounds of high blood pressure, limited vision, flat feet, and punctured eardrums.He met Tabitha Spruce in the stacks of the Fogler Library at the University, where they both worked as students; they married in January of 1971. As Stephen was unable to find placement as a teacher immediately, the Kings lived on his earnings as a laborer at an industrial laundry, and her student loan and savings, with an occasional boost from a short story sale to men's magazines.Stephen made his first professional short story sale (\"The Glass Floor\") to Startling Mystery Stories in 1967. Throughout the early years of his marriage, he continued to sell stories to men's magazines. Many were gathered into the Night Shift collection or appeared in other anthologies.In the fall of 1971, Stephen began teaching English at Hampden Academy, the public high school in Hampden, Maine. Writing in the evenings and on the weekends, he continued to produce short stories and to work on novels.",
      "genres": ["Horror", "Mystery", "Literature & Fiction"],
      "author_books": [
        {
          "url": "https://www.goodreads.com/book/show/11588.The_Shining",
          "bookId": "11588",
          "name": "The Shining (The Shining, #1)",
          "rating": 4.26,
          "date": 1977
        },
        {
          "url": "https://www.goodreads.com/book/show/830502.It",
          "bookId": "830502",
          "name": "It",
          "rating": 4.25,
          "date": 1986
        },
      ],
    };

    expect(result, expectedtAuthorInfoMap);
  });
}
