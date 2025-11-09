#!/bin/bash

# Скрипт для установки всех необходимых пакетов LaTeX для Manim
# Использование: ./setup_latex.sh

set -e  # Остановка при ошибке

echo "🔍 Поиск пути к tlmgr..."

# Автоматически находим путь к tlmgr
TEXLIVE_PATH=$(find /usr/local/texlive -name tlmgr -type f 2>/dev/null | head -1 | xargs dirname)

if [ -z "$TEXLIVE_PATH" ]; then
    echo "❌ Ошибка: tlmgr не найден!"
    echo "Убедитесь, что BasicTeX установлен: brew install --cask basictex"
    exit 1
fi

echo "✅ Найден путь: $TEXLIVE_PATH"
echo ""

echo "📦 Обновление менеджера пакетов..."
sudo $TEXLIVE_PATH/tlmgr update --self

echo ""
echo "📦 Установка необходимых пакетов LaTeX для Manim..."
sudo $TEXLIVE_PATH/tlmgr install \
  standalone \
  preview \
  dvisvgm \
  amsmath \
  amssymb \
  babel-english \
  babel \
  latex-bin \
  xcolor \
  geometry \
  ulem \
  amscls \
  amsfonts

echo ""
echo "🔄 Обновление базы данных пакетов LaTeX..."
sudo $TEXLIVE_PATH/mktexlsr

echo ""
echo "✅ Проверка установки..."
echo ""

# Проверка LaTeX
if command -v latex &> /dev/null; then
    echo "✅ LaTeX найден: $(which latex)"
else
    echo "⚠️  LaTeX не найден в PATH. Выполните: eval \"\$(/usr/libexec/path_helper)\""
fi

# Проверка dvisvgm
if command -v dvisvgm &> /dev/null; then
    echo "✅ dvisvgm найден: $(which dvisvgm)"
else
    echo "⚠️  dvisvgm не найден в PATH"
fi

# Проверка установленных пакетов
echo ""
echo "📋 Проверка установленных пакетов:"
$TEXLIVE_PATH/tlmgr list --only-installed | grep -E "(standalone|preview|dvisvgm)" || echo "⚠️  Некоторые пакеты не найдены"

echo ""
echo "🎉 Установка завершена!"
echo ""
echo "📝 Следующие шаги:"
echo "1. Перезапустите ядро Jupyter (Kernel → Restart Kernel)"
echo "2. Запустите ячейку инициализации в manim_playground.ipynb"
echo "3. Проверьте, что LaTeX найден в выводе"

