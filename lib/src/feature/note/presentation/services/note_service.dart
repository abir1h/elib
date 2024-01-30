import 'package:flutter/material.dart';
import 'package:html/parser.dart' as html;
import 'package:html/dom.dart' as htmlDom;

import 'package:flutter_quill/flutter_quill.dart';

abstract class _ViewModel {}

mixin NoteService<T extends StatefulWidget> on State<T> implements _ViewModel {
  late _ViewModel _view;
  List<Map<String, dynamic>> convertHtmlToDelta(String htmlContent) {
    final document = html.parse(htmlContent);
    final List<Map<String, dynamic>> ops = [];

    void traverseNode(htmlDom.Node node) {
      if (node is htmlDom.Element) {
        final tag = node.localName?.toLowerCase();

        switch (tag) {
          case 'p':
          case 'div':
          case 'br':
            ops.add({'insert': '\n'});
            break;
          case 'b':
          case 'strong':
            ops.add({'insert': node.text, 'attributes': {'bold': true}});
            break;
          case 'i':
          case 'em':
            ops.add({'insert': node.text, 'attributes': {'italic': true}});
            break;
          case 'u':
            ops.add({'insert': node.text, 'attributes': {'underline': true}});
            break;
          case 'a':
            ops.add({'insert': node.text, 'attributes': {'link': node.attributes['href']}});
            break;
          case 'h1':
          case 'h2':
          case 'h3':
          case 'h4':
          case 'h5':
          case 'h6':
            ops.add({'insert': node.text, 'attributes': {'header': int.parse(tag!.substring(1))}});
            break;
          case 'ul':
          case 'ol':
            final List<Map<String, dynamic>> listOps = [];
            for (final child in node.nodes) {
              traverseNode(child);
            }
            ops.add({'insert': listOps});
            break;
          case 'li':
            final List<Map<String, dynamic>> listItemOps = [];
            for (final child in node.nodes) {
              traverseNode(child);
            }
            ops.add({'insert': listItemOps});
            break;
          case 'blockquote':
            final List<Map<String, dynamic>> blockquoteOps = [];
            for (final child in node.nodes) {
              traverseNode(child);
            }
            ops.add({'insert': blockquoteOps});
            break;
          case 'span':
            final Map<String, dynamic> spanOps = {};
            if (node.attributes.containsKey('style')) {
              final style = node.attributes['style']!;
              final colorMatch = RegExp(r'color:\s*([^;]+)').firstMatch(style);
              final bgColorMatch = RegExp(r'background-color:\s*([^;]+)').firstMatch(style);
              if (colorMatch != null) {
                spanOps['attributes'] = {'color': colorMatch.group(1)};
              }
              if (bgColorMatch != null) {
                spanOps['attributes'] = {'background': bgColorMatch.group(1)};
              }
            }
            for (final child in node.nodes) {
              traverseNode(child);
            }
            ops.add({'insert': node.text, ...spanOps});
            break;
          case 'br':
            ops.add({'insert': '\n'});
            break;
          case 'hr':
            ops.add({'insert': '\n', 'attributes': {'block': 'horizontal-line'}});
            break;
          case 'center':
            final List<Map<String, dynamic>> centerOps = [];
            for (final child in node.nodes) {
              traverseNode(child);
            }
            ops.add({'insert': centerOps, 'attributes': {'align': 'center'}});
            break;
          case 'div':
            if (node.attributes.containsKey('align')) {
              ops.add({'insert': '\n', 'attributes': {'align': node.attributes['align']}});
            } else {
              for (final child in node.nodes) {
                traverseNode(child);
              }
            }
            break;
          default:
            for (final child in node.nodes) {
              traverseNode(child);
            }
        }
      } else if (node is htmlDom.Text) {
        ops.add({'insert': node.text});
      }
      if (ops.isNotEmpty && !ops.last.containsKey('insert')) {
        ops.last['insert'] = ops.last['insert'].toString() + '\n';
      }
    }

    for (final node in document.body!.nodes) {
      traverseNode(node);
    }

    return ops;
  }  ///Service configurations
  @override
  void initState() {
    _view = this;

    super.initState();
  }
}
