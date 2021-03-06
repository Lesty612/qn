<template>
    <div class="block-loading__root" v-show="isLoading">
        <slot name="spinnerBox">
            <div class="block-loading__spinner-box">
                <div class="block-loading__spinner-wave-dots"></div>
                <p class="block-loading__loading-desc">{{loadingDesc}}</p>
            </div>
        </slot>
    </div>
</template>

<script type="text/ecmascript-6">
    /**
     * @desc loading遮罩层组件
     * @author Lesty
     * @code-date 2017.4.19
     **/
    export default {
        name: 'BlockLoading',
        props: {
            loadingDesc: {
                default: '加载中···'
            },
            // 最少等待时间(loading至少持续多少秒)
            minWaitTime: {
                type: Number,
                default: 500
            }
        },
        created: function() {
            // 显示
            this.$on('load-show', () => {
                this.isLoading = true;
            });

            // 隐藏
            this.$on('load-hide', () => {
                window.setTimeout(() => {
                    this.isLoading = false;
                }, this.minWaitTime);
            });
        },
        data: function() {
            return {
                isLoading: false
            };
        },
        methods: {

        }
    }
</script>

<style lang="less" scoped>
    @size: 8px;
    @wave: -6px;
    @near-wave: -4px;
    @after-wave: 2px;
    @c-wave: #1577c1;
    @c-near-wave: #20a0ff;
    .block-loading__root {
        position: absolute;
        z-index: 999;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;

        background-color: rgba(230, 233, 236, 0.8);
        cursor: wait;
    }

    .block-loading__spinner-box {
        position: absolute;
        top: 50%;
        left: 50%;
        width: 300px;

        -webkit-transform: translate(-50%, -50%);
        -moz-transform: translate(-50%, -50%);
        -ms-transform: translate(-50%, -50%);
        -o-transform: translate(-50%, -50%);
        transform: translate(-50%, -50%);
    }

    .block-loading__loading-desc {
        margin-top: 10px;

        font-size: 16px;
        font-weight: bold;
        text-align: center;
        color: #000;
    }

    .block-loading__spinner-wave-dots {
        position: relative;
        height: @size + 6;
    }

    .block-loading__spinner-wave-dots:before {
        content: '';
        position: absolute;
        top: 50%;
        left: 50%;
        margin-left: -@size/2;
        margin-top: -@size/2;
        width: @size;
        height: @size;
        background-color: @c-near-wave;
        border-radius: 50%;
        animation: linear spinner-wave-dots 2.8s infinite;
    }

    @keyframes spinner-wave-dots{
        0%{
            box-shadow: -@size * 4 0 0 @c-near-wave,
            -@size * 2 0 0 @c-near-wave,
            @size * 2 0 0 @c-near-wave,
            @size * 4 0 0 @c-near-wave;
        }
        5%{
            box-shadow: -@size * 4 @near-wave 0 @c-near-wave,
            -@size * 2 0 0 @c-near-wave,
            @size * 2 0 0 @c-near-wave,
            @size * 4 0 0 @c-near-wave;
            transform: translateY(0);
        }
        10%{
            box-shadow: -@size * 4 @wave 0 @c-wave,
            -@size * 2 @near-wave 0 @c-near-wave,
            @size * 2 0 0 @c-near-wave,
            @size * 4 0 0 @c-near-wave;
            transform: translateY(0);
        }
        15%{
            box-shadow: -@size * 4 @after-wave 0 @c-near-wave,
            -@size * 2 @wave - @near-wave 0 @c-wave,
            @size * 2 -@near-wave 0 @c-near-wave,
            @size * 4 -@near-wave 0 @c-near-wave;
            transform: translateY(@near-wave);
            background-color: @c-near-wave;
        }
        20%{
            box-shadow: -@size * 4 -@wave 0 @c-near-wave,
            -@size * 2 @near-wave - @wave + @after-wave 0 @c-near-wave,
            @size * 2 @near-wave - @wave 0 @c-near-wave,
            @size * 4 -@wave 0 @c-near-wave;
            transform: translateY(@wave);
            background-color: @c-wave;
        }
        25%{
        @offset: @near-wave + @after-wave;
            box-shadow: -@size * 4 -@offset 0 @c-near-wave,
            -@size * 2 -@offset 0 @c-near-wave,
            @size * 2 @wave - @offset 0 @c-wave,
            @size * 4 @near-wave - @offset 0 @c-near-wave;
            transform: translateY(@offset);
            background-color: @c-near-wave;
        }
        30%{
            box-shadow: -@size * 4 0 0 @c-near-wave,
            -@size * 2 0 0 @c-near-wave,
            @size * 2 @near-wave + @after-wave 0 @c-near-wave,
            @size * 4 @wave 0 @c-wave;
            transform: translateY(0);
        }
        35%{
            box-shadow: -@size * 4 0 0 @c-near-wave,
            -@size * 2 0 0 @c-near-wave,
            @size * 2 0 0 @c-near-wave,
            @size * 4 @near-wave + @after-wave 0 @c-near-wave;
        }
        40%{
            box-shadow: -@size * 4 0 0 @c-near-wave,
            -@size * 2 0 0 @c-near-wave,
            @size * 2 0 0 @c-near-wave,
            @size * 4 0 0 @c-near-wave;
        }
        100%{
            box-shadow: -@size * 4 0 0 @c-near-wave,
            -@size * 2 0 0 @c-near-wave,
            @size * 2 0 0 @c-near-wave,
            @size * 4 0 0 @c-near-wave;
        }
    }
</style>