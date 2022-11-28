#!/usr/bin/env zx

$.verbose = false;

const logo = `
  ┌────────────────────────┐
  │   InsisVim installer   |
  └────────────────────────┘
`;

const zh = {
  quit: '退出',
  continue: '继续',
  choose: '选择',
  envCheck: '开始环境检测',
  found: '已找到',
  notFound: '没有找到，请安装后再尝试',
  alreadyExist: '已存在，自动备份后继续？',
  backupAs: '备份为',
  pluginsFolder: '插件目录',
  startDownload: '开始下载全新配置，请稍后...',
  downloadSuccessful: '下载成功',
  startDownloadPacker: '开始下载插件管理packer.nvim...',
  notice: `安装完成，运行以下命令开启 Neovim 并安装插件（需要科学网络环境）\n\n nvim +PackerSync \n\n 如遇失败可运行 :PackerSync 重新尝试`
}

const en = {
  quit: 'quit',
  continue: 'continue',
  choose: 'choose',
  envCheck: 'start environment checks',
  found: 'found',
  notFound: 'not found, please try again after installation',
  alreadyExist: 'already exists, backup and continue? ',
  backupAs: 'backup as',
  pluginsFolder: 'plugins folder',
  startDownload: 'Start downloading the new configuration, please wait...',
  downloadSuccessful: 'Download successful',
  startDownloadPacker: 'Start downloading packer.nvim...',
  notice: `complete! run command below to install plugins \n\n nvim +PackerSync`
}

let lang = en;

function green(message) {
  console.log(chalk.green(message));
}

function red(message) {
  console.error(chalk.red(message));
}

function blue(message) {
  console.log(chalk.blue(message));
}

function exit(errorMessage) {
  red(errorMessage);
  red(lang.quit);
  process.exit(1);
}

async function yesOrNo(questionString, yesString, yesFunc, noString, noFunc) {
  let res = "";
  while (res === "") {
    res = await question(questionString + ` ([y] ${yesString} / [n] ${noString}): `);
  }
  res.toLowerCase().startsWith("y") ? yesFunc() : noFunc();
}

async function yesOrQuit(questionString, func) {
  await yesOrNo(questionString, lang.continue, func, lang.quit, () => exit(`${lang.choose} No`))
}

blue(logo);

await yesOrNo('Continue in English ? ', 'English', () => lang = en, '中文', () => lang = zh)

blue(`${lang.envCheck} ...`);

const checklist = ["git", "node", "nvim", "rg", "wget", "curl"];

let program;
try {
  blue("");
  for (program of checklist) {
    await $`which ${program}`;
    green(`-> ${program} ${lang.found}`);
  }
} catch (error) {
  exit(`${program} ${lang.notFound}`);
}

// TODO: check $XDG_CONFIG_HOME ?

const home = os.homedir();
await cd(home);
// backup nvim folder
const nvimDir = ".config/nvim";
if (await fs.pathExists(nvimDir)) {
  green(``);
  await yesOrQuit(`${nvimDir} ${lang.alreadyExist}`, async () => {
    const filename = `${nvimDir}.${new Date().toISOString()}.bak`;
    green(``);
    green(`${lang.backupAs} ${filename}`);
    await $`mv .config/nvim ${filename}`;
  });
}

//  backup old plugins
const pluginsDir = ".local/share/nvim/site";
if (await fs.pathExists(pluginsDir)) {
  green(``);
  await yesOrQuit(
    `${lang.pluginsFolder} ${pluginsDir} ${lang.alreadyExist}`,
    async () => {
      const filename = `${pluginsDir}.${new Date().toISOString()}.bak`;
      green(``);
      green(`${lang.backupAs} ${filename}`);
      await $`mv .local/share/nvim/site ${filename}`;
    }
  );
}

$.verbose = true;
blue("");
blue(`${lang.startDownload}`);

// red(await $`pwd`);
await $`git clone --depth 1 https://github.com/nshen/insisVim ${nvimDir}`;

blue("");
green(`${lang.downloadSuccessful}`);

blue("");
blue(`${lang.startDownloadPacker}`);

await $`git clone --depth 1 https://github.com/wbthomason/packer.nvim .local/share/nvim/site/pack/packer/start/packer.nvim`;

green("");
green(`${lang.downloadSuccessful}`);

green(`${lang.notice}`);

