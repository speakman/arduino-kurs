<script setup lang="ts">
defineProps<{
  eyebrow: string
  title: string
  img: string
  caption?: string
  /** Optional side-panel reference (HTML string, e.g. pin-list). */
  reference?: string
}>()
</script>

<template>
  <div class="h-full flex flex-col px-10 py-6">
    <div class="flex items-baseline justify-between flex-shrink-0 mb-1">
      <div class="text-xs font-mono uppercase tracking-[0.3em] opacity-50">
        {{ eyebrow }}
      </div>
      <div class="text-[0.65rem] font-mono opacity-35">
        Elegoo Basic Starter Kit
      </div>
    </div>

    <h1 class="text-4xl leading-tight mb-2 flex-shrink-0">{{ title }}</h1>

    <div class="flex-1 min-h-0 flex items-center justify-center gap-6 my-1">
      <img
        :src="img"
        class="max-h-full max-w-full object-contain rounded-lg shadow-2xl ring-1 ring-white/10"
      />
      <div
        v-if="reference"
        class="flex-shrink-0 max-w-[18rem] text-sm opacity-85 leading-relaxed"
        v-html="reference"
      />
    </div>

    <div
      v-if="caption"
      class="flex-shrink-0 mt-2 text-xs opacity-65 text-center max-w-4xl mx-auto leading-relaxed"
      v-html="caption"
    />
  </div>
</template>
