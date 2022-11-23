/**
_____________________________________________________________________________/\\\________/\\\\\_________________________________
 ____________________________________________________________________________\/\\\______/\\\///\\\_______________________________
  ______________________/\\\__________________________________________________\/\\\____/\\\/__\///\\\_____________________________
   ____/\\\\\__/\\\\\___\///______/\\\\\\\\__/\\/\\\\\\\______/\\\\\___________\/\\\___/\\\______\//\\\__/\\\\\\\\\\_____/\\\\\\\\_
    __/\\\///\\\\\///\\\__/\\\___/\\\//////__\/\\\/////\\\___/\\\///\\\____/\\\\\\\\\__\/\\\_______\/\\\_\/\\\//////____/\\\//////__
     _\/\\\_\//\\\__\/\\\_\/\\\__/\\\_________\/\\\___\///___/\\\__\//\\\__/\\\////\\\__\//\\\______/\\\__\/\\\\\\\\\\__/\\\_________
      _\/\\\__\/\\\__\/\\\_\/\\\_\//\\\________\/\\\_________\//\\\__/\\\__\/\\\__\/\\\___\///\\\__/\\\____\////////\\\_\//\\\________
       _\/\\\__\/\\\__\/\\\_\/\\\__\///\\\\\\\\_\/\\\__________\///\\\\\/___\//\\\\\\\/\\____\///\\\\\/______/\\\\\\\\\\__\///\\\\\\\\_
        _\///___\///___\///__\///_____\////////__\///_____________\/////______\///////\//_______\/////_______\//////////_____\////////__

* @date: June, 2021
*/

(
// Start Proxy
p = ProxySpace(s).push;
p[\tempo] = 110 / 60;
p.quant = 4;
p.fadeTime = 20;
StageLimiter.new(2);
)

(
// Panes
s.plotTree;
s.scope(2);
s.makeWindow;
m = ProxyMixer(p, 8);
m.parent.alwaysOnTop_(true);
PdefAllGui.new;
)

(
~a1.play;
~a2.play;
~b1.play;
~b0.play;
~b2.play;
~b3.stop;
~blowPass.play;
~a2.release(20);
~b2.release(20);
)

(
~a1 = {
    var input;
    Klank.ar(
        specificationsArrayRef: `[
            [4, 1, 3, 5, 7],
            Array.fill(4, 0.05),
            Array.fill(4, 1)
        ],
        input: { ClipNoise.ar(0.02) }.dup,
        freqscale: 360
    )
}
)

(
~a2 = {
    Klank.ar(
        specificationsArrayRef: `[
            Array.geom(4, 1, 1.61),
            Array.fill(4, 0.05),
            Array.fill(4, 1)
        ],
        input: { ClipNoise.ar(0.03) }.dup,
        freqscale: 160
    )
}
)

(
~b0 = {
    LFSaw.ar(
        freq: ([28, 40] + LFNoise0.ar(~tempo.kr * 8).range(0.1, 4)).midicps,
        iphase: 0,
        mul: Decay.ar(in: Impulse.ar(~tempo.kr).lag, decayTime: 3, mul: 0.3)
    )
}
)

(
~b1 = {
    LFSaw.ar(
        freq: ([28,40] + LFNoise0.ar(~tempo.kr / 2).range(1, 1)).midicps,
        iphase: 0,
        mul: LFSaw.kr(~tempo.kr / 2).range(0, 0.3)
    )
}
)

(
~blowPass = {
    BLowPass4.ar(
        in: ~b1.ar,
        freq: SinOsc.kr(~tempo.kr / 16).range(700, 20000),
        rq: 0.4
    )
}
)

(
~b2 = {
    var sig1, sig2;
    sig1 = LFSaw.ar(
        freq: [53, 65].midicps + LFNoise0.ar(~tempo.kr * 4).range(1, 12),
        iphase: 0,
        mul: LFSaw.kr(~tempo.kr / 4).range(0.01, 0.3)
    );
    sig2 = LFPulse.ar(~tempo.kr / 8).range(0.2, 1);
    sig1 * sig2;
}
)

(
~b3 = {
    SinOscFB.ar(
        freq: [52, 64].midicps + 12,
        feedback: LFSaw.kr(~tempo.kr / 4).range(0.01, 1),
        mul: LFSaw.kr(~tempo.kr * 4).range(0, 0.5)
    )
}
)