// For 1.0 release only
const parserOpts = {
  headerPattern: /^\[(\w*)] (.*)$/,
  headerCorrespondence: [`type`, `subject`],
};

const writerOpts = {
  transform: (commit, context) => {
    let discard = true;
    const issues = [];

    commit.notes.forEach(note => {
      note.title = `BREAKING CHANGES`;
      discard = false;
    });

    if (commit.type === 'breaking') {
      commit.type = 'Breaking Changes';
      discard = false;
    }

    // Re-categorize
    if (commit.type === 'dokku' || commit.type == 'heroku') {
      commit.scope = commit.type;
      commit.type = 'deploy';
    }
    if (commit.type === 'readme') {
      commit.type = 'docs';
    }
    if (commit.type === 'codeclimate' || commit.type === 'travis') {
      commit.scope = commit.type;
      commit.type = 'ci';
    }
    if (commit.type === 'config') {
      commit.type = 'improvement';
    }
    if (commit.type === 'blazer') {
      commit.type = 'fix';
    }

    // Set up sections
    if (commit.type === `feature` || commit.type === 'feat') {
      commit.type = `Features`;
    } else if (commit.type === `improvement`) {
      commit.type = `Improvements`;
    } else if (commit.type === `fix`) {
      commit.type = `Bug Fixes`;
    } else if (commit.type === `perf`) {
      commit.type = `Performance Improvements`;
    } else if (commit.type === `revert`) {
      commit.type = `Reverts`;
    } else if (commit.type === `docs`) {
      commit.type = `Documentation`;
    } else if (commit.type === `style`) {
      commit.type = `Styles`;
    } else if (commit.type === `refactor`) {
      commit.type = `Code Refactoring`;
    } else if (commit.type === `test`) {
      commit.type = `Tests`;
    } else if (commit.type === `deploy`) {
      commit.type = `Deployment`;
    } else if (discard) {
      return;
    } else if (commit.type === `build`) {
      commit.type = `Build System`;
    } else if (commit.type === `ci`) {
      commit.type = `Continuous Integration`;
    }

    if (commit.scope === `*`) {
      commit.scope = ``;
    }

    if (typeof commit.hash === `string`) {
      commit.hash = commit.hash.substring(0, 7);
    }

    if (typeof commit.subject === `string`) {
      let url = context.repository
        ? `${context.host}/${context.owner}/${context.repository}`
        : context.repoUrl;
      if (url) {
        url = `${url}/issues/`;
        // Issue URLs.
        commit.subject = commit.subject.replace(/#([0-9]+)/g, (_, issue) => {
          issues.push(issue);
          return `[#${issue}](${url}${issue})`;
        });
      }
      if (context.host) {
        // User URLs.
        commit.subject = commit.subject.replace(
          /\B@([a-z0-9](?:-?[a-z0-9/]){0,38})/g,
          (_, username) => {
            if (username.includes('/')) {
              return `@${username}`;
            }

            return `[@${username}](${context.host}/${username})`;
          }
        );
      }
    }

    // remove references that already appear in the subject
    commit.references = commit.references.filter(reference => {
      if (issues.indexOf(reference.issue) === -1) {
        return true;
      }

      return false;
    });

    return commit;
  },
  groupBy: `type`,
  commitGroupsSort: `title`,
  commitsSort: [`scope`, `subject`],
  noteGroupsSort: `title`,
};

module.exports = {
  plugins: [
    [
      '@semantic-release/commit-analyzer',
      {
        preset: 'angular',
        releaseRules: [{ type: 'breaking', release: 'major' }],
        parserOpts,
      },
    ],
    [
      '@semantic-release/release-notes-generator',
      {
        preset: 'angular',
        parserOpts,
        writerOpts,
      },
    ],
    '@semantic-release/github',
  ],
};
