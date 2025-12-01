#!/usr/bin/env python3
import os
import argparse

ROOT_REL = os.path.join('permisos','src','main','webapp','jsp','gestion')
OPEN_TAG = '<div id="apliweb-tabform">'
CLOSE_TAG = '</div>'
INCLUDE_START = '<%@ include file="/jsp/gestion/includes/layout_start.jsp" %>'
INCLUDE_END = '<%@ include file="/jsp/gestion/includes/layout_end.jsp" %>'
BACKUP_EXT = '.bak_apliweb'


def process_file(path, make_backup=True):
    with open(path, 'r', encoding='utf-8') as f:
        s = f.read()
    if OPEN_TAG not in s:
        return False
    start = s.find(OPEN_TAG)
    # find the first closing </div> after the opening tag
    close = s.find(CLOSE_TAG, start)
    if close == -1:
        return False
    # replace opening tag
    new = s[:start] + INCLUDE_START + s[start + len(OPEN_TAG):close] + INCLUDE_END + s[close + len(CLOSE_TAG):]
    if make_backup:
        with open(path + BACKUP_EXT, 'w', encoding='utf-8') as b:
            b.write(s)
    with open(path, 'w', encoding='utf-8') as f:
        f.write(new)
    return True


def find_files(root):
    matches = []
    for dirpath, dirs, files in os.walk(root):
        for fn in files:
            if not fn.lower().endswith('.jsp'):
                continue
            fp = os.path.join(dirpath, fn)
            try:
                with open(fp, 'r', encoding='utf-8') as f:
                    data = f.read()
                if OPEN_TAG in data:
                    matches.append(fp)
            except Exception:
                pass
    return sorted(matches)


def main():
    parser = argparse.ArgumentParser(description='Replace apliweb tab div with layout includes')
    parser.add_argument('--root', help='Path to jsp/gestion root', default=ROOT_REL)
    parser.add_argument('--limit', type=int, default=0, help='Limit number of files to process (0 = all)')
    parser.add_argument('--no-backup', action='store_true', help='Do not create backup files')
    args = parser.parse_args()

    root = args.root
    if not os.path.isabs(root):
        root = os.path.join(os.getcwd(), root)
    if not os.path.isdir(root):
        print('ERROR: root path not found:', root)
        return 2

    files = find_files(root)
    print('Found', len(files), 'files with apliweb-tabform')
    to_process = files[:args.limit] if args.limit and args.limit > 0 else files
    print('Processing', len(to_process), 'files')
    changed = []
    for fp in to_process:
        ok = process_file(fp, make_backup=not args.no_backup)
        if ok:
            changed.append(fp)
            print('Changed:', fp)
        else:
            print('Skipped (no match or structure unexpected):', fp)
    print('\nDone. Modified', len(changed), 'files.')
    if len(changed) > 0:
        print('Backups created with extension', BACKUP_EXT)
    return 0

if __name__ == '__main__':
    exit(main())
